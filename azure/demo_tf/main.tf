resource "random_string" "random" {
  length           = 4
  special          = false
  upper            = false
}


module "infra" {
    source = "../modules/infra"
    
    #General Variables Common accross the enviornments
    name = var.name
    location = var.location
    environment = var.environment
    common_name_prefix = "${var.common_name_prefix}${random_string.random.id}"
    resource_group_name = var.resource_group_name
    shared_name_prefix  = var.shared_name_prefix
    tags= {
        CreatedBy = "Terraform"
        ManagedBy = "CodePipes"
    }

    #VNET Variables 
    vnet_address_space = ["10.0.0.0/16"]

    #Subnet Variables 
    subnet_address_prefixes = {
        "aks"={
          subnet = "10.0.0.0/20",
          delegation = null
          },
        "redis"= {
          subnet="10.0.18.0/24",
          delegation = null
          },
        "agic" = {
          subnet="10.0.17.0/24",
          delegation = null
          },
        "psql" = {
          subnet="10.0.19.0/24",
          delegation = {
            name = "psql-delegation",
            service_delegation = {
            name = "Microsoft.DBforPostgreSQL/flexibleServers",
            actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
            }
            }
          }
    }
    subnet_service_endpoints =[]
    subnet_enforce_private_link_endpoint_network_policies = true

    #NSG Variables
    nsg_security_rule = [
    {
      name                       = "allow-tunnelfront-traffic"
      description                = "Allow internal traffic on 10250"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_ranges         = ["*"]
      destination_port_ranges    = ["10250"]
      source_address_prefix      = "10.40.0.0/20"
      destination_address_prefix = "10.40.0.0/20"
    },
    {
      name                       = "allow-acig-traffic"
      description                = "Allow AGIC Internal traffic"
      priority                   = 102
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_ranges         = ["*"]
      destination_port_ranges    = ["*"]
      source_address_prefix      = "10.40.17.0/24"
      destination_address_prefix = "10.40.0.0/20"
    },
    {
      name                       = "allow-443-port"
      description                = "Allow Internal traffic"
      priority                   = 104
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_ranges         = ["*"]
      destination_port_ranges    = ["443"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-80-port"
      description                = "Allow Internal traffic"
      priority                   = 105
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_ranges         = ["*"]
      destination_port_ranges    = ["80","65200-65535"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]

    #Public IP Variables
    sku_public_ip       = var.sku_public_ip
    public_ip_allocation_method   = var.public_ip_allocation_method
  
    #AGIC Variables
    sku_agic = {
      name     = "Standard_v2"
      tier     = "Standard_v2"
      capacity = 1
    }
    private_ip_address_agic = var.private_ip_address_agic
    agic_services = [
      {
        name = "aks-agic"
        priority = 100
        http_listener = {
          protocol = "Http"
        }

        backend_address_pool = {
          ip_addresses = []
        }

        probe = {
          protocol            = "Http"
          path                = "/"
          interval            = 30
          timeout             = 120
          unhealthy_threshold = 8
        }

        backend_http_settings = {
          protocol              = "Http"
          port                  = 80
          path                  = "/"
          cookie_based_affinity = "Disabled"
          request_timeout       = 180
        }
      }
    ]
    autoscale_configuration = {
      min_capacity = 0
      max_capacity = 10
    }

    #AKS
    aks_dns_prefix = var.aks_dns_prefix
    aks_admin_username = var.aks_admin_username
    aks_service_cidr = var.aks_service_cidr
    aks_dns_service_ip = var.aks_dns_service_ip
    aks_docker_bridge_cidr = var.aks_docker_bridge_cidr
    aks_role_based_access_control = var.aks_role_based_access_control
    aks_azure_active_directory_enabled = var.aks_azure_active_directory_enabled
    aks_admin_group_object_ids = ["3be269bd-117e-41a9-b988-09f6cf860b0e"]
    aks_enable_auto_scaling = var.aks_enable_auto_scaling
    aks_node_min_count = var.aks_node_min_count
    aks_node_max_count = var.aks_node_max_count
    aks_kubernetes_version = var.aks_kubernetes_version
    aks_max_pods = var.aks_max_pods
    aks_public_ssh_key = var.aks_public_ssh_key
    client_id = var.client_id
    client_secret = var.client_secret
    node_size = var.node_size

    #Redis
    redis_capacity                 = var.redis_capacity
    redis_family                   = var.redis_family
    redis_sku_name                 = var.redis_sku_name
    redis_enable_authentication    = var.redis_enable_authentication
    redis_version                  = var.redis_version
    enable_non_ssl_port            = var.redis_enable_non_ssl_port

    redis_patch_day_of_week        = var.redis_patch_day_of_week
    redis_patch_start_hour_utc     = var.redis_patch_start_hour_utc
    redis_patch_maintenance_window = var.redis_patch_maintenance_window

    #Postgres Server
    postgres_administrator_login = var.postgres_administrator_login
    postgres_administrator_login_password = var.postgres_administrator_login_password

    postgres_sku_name            = var.postgres_sku_name
    postgres_version             = var.postgres_version
    postgres_storage_mb          = var.postgres_storage_mb

    postgres_backup_retention_days        = var.postgres_backup_retention_days
    postgres_geo_redundant_backup_enabled = var.postgres_geo_redundant_backup_enabled
    postgres_auto_grow_enabled            = var.postgres_auto_grow_enabled

    postgres_public_network_access_enabled    = var.postgres_public_network_access_enabled
    postgres_ssl_enforcement_enabled          = var.postgres_ssl_enforcement_enabled
    // postgres_ssl_minimal_tls_version_enforced = "TLS1_2"

    postgres_identity_type = var.postgres_identity_type

    #Postgres Database
    postgres_db_charset   = var.postgres_db_charset
    postgres_db_collation = var.postgres_db_collation

    #Postgres VNET Rules Subnet not working
    // postgres_vnet_ignore_missing_vnet_service_endpoint = false

    #Postgres Private Link Rule
    private_endpoint_subresource_names              = ["postgresqlServer"]
    private_endpoint_is_manual_connection           = var.private_endpoint_is_manual_connection

    #Storage Account Variables
    storage_account_kind        = var.storage_account_kind
    storage_account_tier        = var.storage_account_tier
    storage_access_tier         = var.storage_access_tier
    storage_account_replica     = var.storage_account_replica
    storage_min_tls_version     = var.storage_min_tls_version

    #Storage Container Variables
    storage_container_name = var.storage_container_name
}