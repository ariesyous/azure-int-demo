#Local Variables
locals {
    public_ip_address = join("", module.public_ip.*.public_ip_address)
    public_ip_id      = join("", module.public_ip.*.public_ip_id)
}

#Data Sources
data "azurerm_client_config" "current" {
}

data "azuread_service_principal" "current" {
    application_id = data.azurerm_client_config.current.client_id
}

data "azurerm_application_gateway" "main" {

    count = var.appgw_name != null ? 1 : 0

    name                = var.appgw_name
    resource_group_name = var.appgw_resource_group == null ? var.resource_group_name : var.appgw_resource_group
}

data "azurerm_subnet" "appgw" {

    count = var.appgw_name != null ? 1 : 0

    name                 = var.appgw_subnet_name
    virtual_network_name = var.appgw_vnet_name
    resource_group_name  = var.appgw_resource_group == null ? var.resource_group_name : var.appgw_resource_group
}

module "resource_group" {
    source = "../resource-group"
    #Common Variables
    name = var.name
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    tags =  var.tags
}



#Resources
resource "random_string" "random" {
  length           = 4
  special          = false
}

#Modules
module "vnet" {
    source = "../vnet"

    #Common Variables
    name                = var.name
    location            = var.location
    tags =  var.tags
    environment = var.environment
    number = "001"
    shared_name_prefix = var.shared_name_prefix

    resource_group_name = module.resource_group.name

    #VNET Variables
    address_space       = var.vnet_address_space
}

module "subnet" {
    source = "../subnet"

    #Common Variables
    name = "${var.name}-${each.key}"
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name

    #Subnet Variables
    for_each = var.subnet_address_prefixes
    virtual_network_name = module.vnet.vnet_name
    address_prefixes     = each.value.subnet
    subnet_prefix        = each.key
    delegation           = each.value.delegation
    service_endpoints    = var.subnet_service_endpoints
    enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies

    #Dependency
    depends_on = [
        module.vnet,
    ]

}


module "nsg_aks" {
    source = "../network-security-group"

    #Common Variables
    name = var.name
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name
    tags =  var.tags

    #NSG Variables
    subnet_id = module.subnet["aks"].subnet_id
    security_rule = var.nsg_security_rule

    #Dependency
    depends_on = [
        module.subnet,
    ]

}

module "nsg_agic" {
    source = "../network-security-group"

    count = var.appgw_name != null ? 1 : 0


    #Common Variables
    name = var.name
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name  = var.appgw_resource_group == null ? var.resource_group_name : var.appgw_resource_group
    tags =  var.tags

    #NSG Variables
    subnet_id = data.azurerm_subnet.appgw[0].id
    security_rule = var.nsg_security_rule

    #Dependency
    depends_on = [
        module.subnet,
    ]

}

module "public_ip" {
    source = "../public-ip"

    #Common Variables
    name = var.name
    number = "001"
    location = var.location
    environment = var.environment
    shared_name_prefix = var.shared_name_prefix
    resource_group_name = module.resource_group.name
    resource_prefix  = "vpn"
    tags =  var.tags

    #Public IP Variables
    sku                 = var.sku_public_ip
    allocation_method   = var.public_ip_allocation_method

    depends_on = [
      module.subnet,
    ]

}



module "vpn_public_ip" {
    source = "../public-ip"

    count = var.vpn_gateway_enabled == true ? 1 : 0

    #Common Variables
    name = var.name
    number = "002"
    location = var.location
    environment = var.environment
    shared_name_prefix = var.shared_name_prefix
    resource_group_name = module.resource_group.name
    tags =  var.tags
    resource_prefix  = ""

    #Public IP Variables
    sku                 = var.sku_public_ip
    allocation_method   = var.public_ip_allocation_method

    depends_on = [
        module.subnet,
    ]


}

module "aks" {
    source = "../aks"

    #Common Variables
    name = var.name
    number = "001"
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name
    tags =  var.tags

    #AKS Variables
    vnet_subnet_id                 = module.subnet["aks"].subnet_id
    subnet_name                    = module.subnet["aks"].subnet_name

    dns_prefix                     = var.aks_dns_prefix
    admin_username                 = var.aks_admin_username

    public_ssh_key                 = var.aks_public_ssh_key
    client_id                      = var.client_id
    client_secret                  = var.client_secret
    private_cluster_enabled        = var.private_cluster_enabled


    service_cidr                   = var.aks_service_cidr
    dns_service_ip                 = var.aks_dns_service_ip
    docker_bridge_cidr             = var.aks_docker_bridge_cidr
    role_based_access_control      = var.aks_role_based_access_control
    azure_active_directory_enabled = var.aks_azure_active_directory_enabled
    
    admin_group_object_ids         = var.aks_admin_group_object_ids
    enable_auto_scaling            = var.aks_enable_auto_scaling
    node_min_count                 = var.aks_node_min_count
    node_max_count                 = var.aks_node_max_count
    initial_node_count             = var.aks_node_min_count
    node_size                      = var.node_size
    kubernetes_version             = var.aks_kubernetes_version
    max_pods                       = var.aks_max_pods

}


module "redis" {
    source = "../azure_redis"

    #Common Variables
    name = var.name
    location = var.location
    environment = var.environment
    number = "002"
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name
    tags =  var.tags

    #Redis Variables
    capacity            = var.redis_capacity
    family              = var.redis_family
    sku_name            = var.redis_sku_name
    enable_authentication = var.redis_enable_authentication
    redis_version         = var.redis_version
    subnet_id       = module.subnet["redis"].subnet_id
    enable_non_ssl_port = var.enable_non_ssl_port

    patch_day_of_week        = var.redis_patch_day_of_week
    patch_start_hour_utc     = var.redis_patch_start_hour_utc
    patch_maintenance_window = var.redis_patch_maintenance_window
}

# module "postgres_sql_server" {
#     source = "../postgres_flex_sql_server"

#     #Common Variables
#     name = var.name
#     location = var.location
#     environment = var.environment
#     common_name_prefix = var.common_name_prefix
#     resource_group_name = module.resource_group.name
#     tags =  var.tags

#     #Postgres Variables
#     administrator_login          = var.postgres_administrator_login
#     administrator_login_password = var.postgres_administrator_login_password

#     registration_enabled = var.registration_enabled

#     postgres_delegated_subnet_id = module.subnet["psql"].subnet_id
#     postgres_virtual_network_id  = module.vnet.vnet_id

#     sku_name         = var.postgres_sku_name
#     postgres_version = var.postgres_version
#     storage_mb       = var.postgres_storage_mb

#     backup_retention_days        = var.postgres_backup_retention_days
#     geo_redundant_backup_enabled = var.postgres_geo_redundant_backup_enabled
#     depends_on = [
#       module.subnet,
#     ]

# }

module "postgres_sql_server" {
    source = "../postgres_sql_server"

    #Common Variables
    name = var.name
    location = var.location
    number = "001"
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name
    tags =  var.tags

    administrator_login          = var.postgres_administrator_login
    administrator_login_password = var.postgres_administrator_login_password

    sku_name         = var.postgres_sku_name
    postgres_version = var.postgres_version
    storage_mb       = var.postgres_storage_mb

    backup_retention_days        = var.postgres_backup_retention_days
    geo_redundant_backup_enabled = var.postgres_geo_redundant_backup_enabled
    auto_grow_enabled            = var.postgres_auto_grow_enabled

    public_network_access_enabled    = var.postgres_public_network_access_enabled
    ssl_enforcement_enabled          = var.postgres_ssl_enforcement_enabled
    ssl_minimal_tls_version_enforced = var.postgres_ssl_minimal_tls_version_enforced

    identity_type = var.postgres_identity_type
}

module "postgres_sql_database" {
    source = "../postgres_sql_database"

    #Common Variables
    name = var.name
    location = var.location
    number = "001"
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name
    tags =  var.tags

    #Postgres Database variables
    postgres_server_name = module.postgres_sql_server.name
    charset                 = var.postgres_db_charset
    collation               = var.postgres_db_collation

    depends_on = [
      module.postgres_sql_server,
    ]
}

# module "postgres_sql_database" {
#     source = "../postgres_flex_sql_database"

#     #Common Variables
#     name = var.name
#     location = var.location
#     environment = var.environment
#     common_name_prefix = var.common_name_prefix
#     tags =  var.tags

#     #Postgres Database variables
#     postgres_flex_server_id = module.postgres_sql_server.postgres_server_id
#     charset                 = var.postgres_db_charset
#     collation               = var.postgres_db_collation

#     depends_on = [
#       module.postgres_sql_server,
#     ]
# }
#Disabled as it does not work currently. Using Private Endpoint (used below) is currently the way to proceed as a workaround.
// module "postgres_vnet_rule" {
//     source = "../postgres_vnet_rule"

//     #Common Variables
//     name = var.name
//     location = var.location
//     environment = var.environment
//     common_name_prefix = var.common_name_prefix
//     resource_group_name = module.resource_group.name
//     tags =  var.tags

//     #Postgres VNET Rule variables
//     postgres_server_name = module.postgres_sql_server.name
//     ignore_missing_vnet_service_endpoint = var.postgres_vnet_ignore_missing_vnet_service_endpoint
//     postgres_subnet_id = module.subnet["aks"].subnet_id
// }

module "private_endpoint" {
    source = "../private_endpoint"

    #Common Variables
    name = var.name
    app = "db"
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name
    tags =  var.tags

    #Private Endpoint Variables
    subnet_id           = module.subnet["aks"].subnet_id

    private_connection_resource_id = module.postgres_sql_server.postgres_server_id
    subresource_names              = var.private_endpoint_subresource_names
    is_manual_connection           = var.private_endpoint_is_manual_connection
}

module "storage_account" {
    source = "../storage-account"

    #Common Variables
    name = var.name
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name
    tags =  var.tags
    random_id = random_string.random.id

    #Storage Account Variables
    account_kind        = var.storage_account_kind
    account_tier        = var.storage_account_tier
    access_tier         = var.storage_access_tier
    account_replica     = var.storage_account_replica
    min_tls_version     = var.storage_min_tls_version
}

module "storage_container" {
    source = "../storage-container"

    #Storage Container Variables
    storage_container_name = "${var.common_name_prefix}-bucket-data"
    storage_account_name   = module.storage_account.storage_account_name
}

// module "istio" {
//     source = "../istio"
//     count = var.istio_enabled ? 1 : 0
//     #Common Variables
//     resource_group_name = module.resource_group.name
    
//     #Istio Variables
//     istio_version          = "1.11.3"
//     aks_client_certificate = base64decode(module.aks.aks_client_certificate)
//     aks_cluster_name   = module.aks.aks_name
//     aks_host           = module.aks.aks_host
//     aks_token          = base64decode(module.aks.aks_client_key)
//     aks_ca_certificate = base64decode(module.aks.aks_cluster_ca_certificate)
//     aks_kubeconfig     = module.aks.aks_kube_config_raw

// }

module "letsencrypt_cert" {
    source = "../letsencrypt-cert"
    count = var.domain_name != "" ? 1 : 0

    #Common Variables
    resource_group_name = module.resource_group.name
    domain_name          = var.domain_name
    subscription_id      = data.azurerm_client_config.current.subscription_id
    client_id            = data.azurerm_client_config.current.client_id
}

module "key_vault" {
    source = "../key-vault/vault"
    #Common Variables
    name = "${var.common_name_prefix}${var.name}kv"
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name

    tenant_id           = data.azurerm_client_config.current.tenant_id
    application_id      = data.azurerm_client_config.current.client_id
    object_id           = data.azuread_service_principal.current.object_id
    random_id           = random_string.random.id
}

module "keys" {
    source = "../key-vault/keys"
    #Common Variables
    name = "${var.common_name_prefix}${var.name}"
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name

    keyvault_id = module.key_vault.id

    depends_on = [
        module.key_vault,
        ]
}

module "certificate" {
    source = "../key-vault/certificates"
    count = var.domain_name != "" ? 1 : 0

    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    key_vault_id = module.key_vault.id

    certificate_p12 = module.letsencrypt_cert[0].certificate_p12
    certificate_p12_password = module.letsencrypt_cert[0].certificate_p12_password
    private_key = module.letsencrypt_cert[0].private_key_pem
}

module "dns_zone" {
    source = "../dns/zones/public"
    count = var.external_domain_name != "" ? 1 : 0
    external_domain_name = var.external_domain_name
    resource_group  = var.resource_group_name
}

module "record_set" {
    source = "../dns/records/public"
    count = var.external_domain_name != "" ? 1 : 0
    dns_zone_name = module.dns_zone[0].zone_name
    resource_group  = var.resource_group_name
    recordsets = [
    {
      name = "@"
      type = "A"
      ttl  = 60
      records = [
        "${local.public_ip_address}"
      ]
    },
    {
      name = "api"
      type = "A"
      ttl  = 60
      records = [
        "${local.public_ip_address}"
      ]
    }
  ]
}


module "vpn_gateway" {
    source = "../vpn/virtual-network-gateway"
    count = var.vpn_gateway_enabled ? 1 : 0
    #Common Variables
    location = var.location
    environment = var.environment
    common_name_prefix = var.common_name_prefix
    resource_group_name = module.resource_group.name
    tags =  var.tags

    #Vpn Gateway Variables
    virtual_network_name = module.vnet.vnet_name
    gateway_type = var.vpn_gateway_type
    vpn_type     = var.vpn_type
    vpn_gw_sku = var.vpn_gw_sku
    enable_active_active = var.enable_active_active
    enable_bgp = var.enable_bgp
    vpn_gw_generation = var.vpn_gw_generation

    #BGP Variables
    bgp_asn_number      = var.bgp_asn_number
    bgp_peering_address = var.bgp_peering_address
    bgp_peer_weight     = var.bgp_peer_weight

    #IP Configuration
    public_ip_address_id = module.vpn_public_ip[0].public_ip_id

    depends_on = [
      module.subnet,module.vpn_public_ip
    ]
}