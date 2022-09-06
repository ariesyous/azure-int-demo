#General Variables
variable "resource_group_name" {
  description = "The Resource Group Name to deploy resources."
  type        = string
}

variable "common_name_prefix" {
  description = "The name prefix for common resources."
  type        = string
}

variable "shared_name_prefix" {
  description = "The name prefix for shared resources."
  type        = string
}

variable "environment" {
  description = "The name type of environment to deploy resoursces"
  type        = string
}


variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

variable "location" {
  description = "The data center location where all resources will be put into."
  type        = string
}

variable "name" {
  description = "name of the resource"
  type        = string
}




# VNET Variables
variable "vnet_dns_servers" {
  description = "The address space that is used the virtual network. You can supply more than one address space."
  type        = list
  default     = []
}
variable "vnet_address_space" {
  description = "The address space of the virtual network connecting all resources."
  type        = list(string)
}


variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })

  default = null
}

#Subnet Variables 

variable "subnet_address_prefixes" {
  type        = any
  description = "The address prefixes to use for the subnet."
  default     = null
}

variable "subnet_service_endpoints" {
  type    = list(string)
  default = []
}

variable "subnet_enforce_private_link_endpoint_network_policies" {
  type        = bool
  description = "Enable or Disable network policies for the private link endpoint on the subnet."
  default     = false
}

#NSG Variables 

variable "nsg_security_rule" {
  type = list(object({
    name                       = string
    description                = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_ranges         = list(string)
    destination_port_ranges    = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

#Public IP Variables

variable "public_ip_allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  default     = "Static"
}
variable "sku_public_ip" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
  default     = "Basic"
}

#AGIC Variables
#private frontend ip
variable "private_ip_address_allocation" {
  type    = string
  default = "Static"
}
variable "private_ip_address_agic" {
  type    = string
  default = ""
}

#Application Gateway Variables
variable "sku_agic" {
  type = object({
    name     = string
    tier     = string
    capacity = number
  })
}

variable "public_ip_info" {
  type = object({
    id = string
    ip = string
  })
  default = {
    id = ""
    ip = ""
  }
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "frontend_port" {
  type = number
  default = 80
}

variable "agic_services" {
  type = list(object({
    name = string
    priority = number
    http_listener = object({
      protocol = string
    })

    backend_address_pool = object({
      ip_addresses = list(string)
    })

    probe = object({
      protocol            = string
      path                = string
      interval            = number
      timeout             = number
      unhealthy_threshold = number
    })

    backend_http_settings = object({
      protocol              = string
      port                  = number
      path                  = string
      cookie_based_affinity = string
      request_timeout       = number
    })
  }))
}

variable "waf_configuration" {
  type = object({
    enabled          = bool
    firewall_mode    = string
    rule_set_type    = string
    rule_set_version = string
    disabled_rule_groups = list(object({
      rule_group_name = string
      rules           = list(string)
    }))
    request_body_check       = bool
    file_upload_limit_mb     = number
    max_request_body_size_kb = number
  })
  default = null
}

variable "autoscale_configuration" {
  type = object({
    min_capacity = number # in the range 0 to 100.
    max_capacity = number # in the range 2 to 125.
  })
  default = null
}

#aks cluster variables 
variable "aks_kubernetes_version" {
  default = "1.18.10"
}

variable "aks_dns_prefix" {
  description = "The prefix for the resources created in the specified Azure Resource Group."
  type        = string
  default     = ""
}
variable "private_cluster_enabled" {
  description = " Kubernetes Cluster have it's API server only exposed on internal IP addresses"
  type        = bool
  default     = false
}
variable "aks_admin_username" {
  default     = "azureuser"
  description = "The username of the local administrator to be created on the Kubernetes cluster"
  type        = string
}

variable "aks_public_ssh_key" {
  description = "A custom ssh key to control access to the AKS cluster"
  type        = string
  default     = null
}

# default node pool 
variable "node_type" {
  default     = "VirtualMachineScaleSets"
  description = "The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets"
  type        = string

}
variable "initial_node_count" {
  description = "The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100 and between min_count and max_count"
  default     = 3
  type        = number

}
variable "node_size" {
  default     = "Standard_D2s_v3"
  description = "The default virtual machine size for the Kubernetes agents"
  type        = string
}
variable "os_disk_size_gb" {
  description = "Disk size of nodes in GBs."
  type        = number
  default     = 50
}
variable "vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist"
  type        = string
  default     = null
}
variable "aks_enable_auto_scaling" {
  description = "default value is set to false."
  type        = string
  default     = false
}
variable "aks_node_min_count" {
  description = "The maximum number of nodes which should exist in this Node Pool"
  type        = number
  default     = null
}
variable "aks_node_max_count" {
  description = "The minimum number of nodes which should exist in this Node Pool"
  type        = number
  default     = null
}
variable "aks_max_pods" {
  description = "The maximum number of pods that can run on each agent"
  type        = number
  default     = null
}

# addon_profile variables
variable "enable_http_application_routing" {
  description = "Enable HTTP Application Routing Addon (forces recreation)."
  type        = bool
  default     = false
}
variable "enabled_oms_agent" {
  description = "enable if you want monitoring in aks"
  type        = bool
  default     = true
}

variable "enabled_aci_connector_linux" {
  description = "for configuring the virtul nodes"
  type        = bool
  default     = false
}
variable "subnet_name" {
  description = "The subnet name for the virtual nodes to run."
  type        = string
  default     = ""
}

# network_profile variables

variable "network_plugin" {
  description = "Network plugin to use for networking. Currently supported values are azure and kubenet"
  type        = string
  default     = "azure"
}

variable "aks_dns_service_ip" {
  description = " IP address within the Kubernetes service address range that will be used by cluster service discovery"
  type        = string
  default     = ""
}

variable "aks_docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes"
  type        = string
  default     = ""
}

variable "aks_service_cidr" {
  description = "The Network Range used by the Kubernetes service"
  type        = string
  default     = ""
}

# variable "network_policy" {
#   description = "Sets up network policy to be used with Azure CNI"
#   type        = string
#   default     = "azure"
# }

variable "outbound_type" {
  description = "he outbound (egress) routing method which should be used for this Kubernetes Cluster"
  type        = string
  default     = "loadBalancer"
}

# variable "pod_cidr" {
#   description = "This field can only be set when network_plugin is set to kubenet"
#   type        = string
#   default     = ""
# }

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are Basic and Standard"
  type        = string
  default     = "Standard"
}

#service principal 
variable "client_id" {
  description = "The Client ID (appId) for the Service Principal used for the AKS deployment"
  type        = string
}

variable "client_secret" {
  description = "The Client Secret (password) for the Service Principal used for the AKS deployment"
  type        = string
}


# analytics variables 
variable "log_analytics_workspace_sku" {
  description = "The SKU (pricing level) of the Log Analytics workspace. For new subscriptions the SKU should be set to PerGB2018"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_in_days" {
  description = "The retention period for the logs in days"
  type        = number
  default     = 30
}

#rbac variables 
variable "aks_role_based_access_control" {
  description = "rbac enabled in aks cluster"
  type        = bool
  default     = true
}

#AD integration 
variable "aks_azure_active_directory_enabled" {
  description = "managed ad integtaion  in aks cluster"
  type        = bool
  default     = true
}

variable "aks_admin_group_object_ids" {
  description = "list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  type        = list(string)
  default     = []
}

#Redis Variables
variable "redis_capacity" {
  description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4"
  type        = number
  default     = 2
}

variable "redis_family" {
  description = " The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)"
  type        = string
  default     = "C"
}

variable "redis_sku_name" {
  description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium."
  type        = string
  default     = "Standard"
}

variable "redis_patch_day_of_week" {
  description = "The Weekday name - possible values include Monday, Tuesday, Wednesday etc."
  type        = string
  default     = "Saturday"
}

variable "redis_patch_start_hour_utc" {
  description = "The Start Hour for maintenance in UTC - possible values range from 0 - 23."
  type        = number
  default     = 23
}

variable "redis_patch_maintenance_window" {
  description = "The ISO 8601 timespan which specifies the amount of time the Redis Cache can be updated. Defaults to PT5H."
  type        = string
  default     = "PT3H"
}

variable "redis_enable_authentication" {
  description = "If set to false, the Redis instance will be accessible without authentication. Defaults to true."
  type        = bool
  default     = false
}

variable "redis_version" {
  description = "Redis version. Only major version needed. Valid values: 4, 6."
  type        = number
  default     = 4
}

variable "enable_non_ssl_port" {
  description = "Enable the non-SSL port (6379) - disabled by default."
  type        = bool
  default     = false
}


#postgres Server Variables
variable "postgres_sku_name" {
  description = "Specifies the SKU Name for this PostgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8). For more information see the product documentation (https://docs.microsoft.com/en-us/rest/api/postgresql/singleserver/servers/create#sku)"
  type        = string
  default     = "B_Standard_B2s"
}

variable "postgres_administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Required when create_mode is Default. Changing this forces a new resource to be created."
  type        = string
}

variable "postgres_administrator_login_password" {
  description = "The Password associated with the administrator_login for the PostgreSQL Server. Required when create_mode is Default."
  type        = string
  default     = null
}

variable "postgres_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are 9.5, 9.6, 10, 10.0, and 11. Changing this forces a new resource to be created."
  type        = string
  default     = "13"
}

variable "postgres_storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 16777216 MB(16TB) for General Purpose/Memory Optimized SKUs. For more information see the product documentation. (https://docs.microsoft.com/en-us/rest/api/postgresql/servers/create#StorageProfile)"
  type        = number
  default     = 32768
}

variable "postgres_backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 7
}

variable "postgres_geo_redundant_backup_enabled" {
  description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not support for the Basic tier. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "postgres_auto_grow_enabled" {
  description = "Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true."
  type        = bool
  default     = false
}

variable "postgres_public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this server."
  type        = bool
  default = false
}

variable "postgres_ssl_enforcement_enabled" {
  description = "Specifies if SSL should be enforced on connections. Possible values are true and false."
  type        = bool
  default     = true
}

variable "postgres_ssl_minimal_tls_version_enforced" {
  description = "The mimimun TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2."
  type        = string
  default     = "TLSEnforcementDisabled"
}

variable "postgres_identity_type" {
  description = "The Type of Identity which should be used for this PostgreSQL Server. At this time the only possible value is SystemAssigned."
  type        = string
  default     = "SystemAssigned"
}

#Postgres Database Variables
variable "postgres_db_charset" {
  description = "Specifies the Charset for the PostgreSQL Database, which needs to be a valid PostgreSQL Charset (https://www.postgresql.org/docs/current/static/multibyte.html). Changing this forces a new resource to be created."
  type        = string
  default     = "UTF8"
}

variable "postgres_db_collation" {
  description = "Specifies the Collation for the PostgreSQL Database, which needs to be a valid PostgreSQL Collation (https://www.postgresql.org/docs/current/static/collation.html). Note that Microsoft uses different notation - en-US instead of en_US. Changing this forces a new resource to be created."
  type        = string
  default     = "English_United States.1252"
}

variable "registration_enabled" {
  description = " Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to false."
  type = bool
  default = false
}

#Postgres VNET Rules Sunbet
// variable "postgres_vnet_ignore_missing_vnet_service_endpoint" {
//   description = "Should the Virtual Network Rule be created before the Subnet has the Virtual Network Service Endpoint enabled? Defaults to false."
//   type        = bool
//   default     = true
// }

#Private Endpoint
variable "private_endpoint_subresource_names" {
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
  type        = list(string)
  default     = []
}

variable "private_endpoint_is_manual_connection" {
  description = "Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
  type        = bool
}

#Storage Account variables
variable "storage_account_replica" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type        = string
}

variable "storage_account_kind" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "StorageV2"
}
variable "storage_account_tier" {
  description = "The Azure storage account tier."
  type        = string
  default     = "Standard"
}
variable "storage_access_tier" {
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
  default     = "Hot"
}

variable "storage_min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2"
  default     = "TLS1_2"
  type        = string
}

#Storage Container Variables

variable "storage_container_name" {
  description = "The storage container name"
  type        = string
}

#Istio
variable "istio_enabled" {
  description = "Enabling this will install istio on the AKS"
  type        = bool
  default     = false
}

#Letencrypt Cert
variable "enable_letsencrypt" {
  description = "The certificate's common name, the primary domain that the certificate will be recognized for. Required when not specifying a CSR. Forces a new resource when changed."
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "The certificate's common name, the primary domain that the certificate will be recognized for. Required when not specifying a CSR. Forces a new resource when changed."
  type        = string
  default     = ""
}

variable "email" {
  description = "Specifies the Resource Group where resource needs to be created."
  type        = string
  default     = "vanguard@cldcvr.com"
}


#DNS Zone
variable "external_domain_name" {
  description = "Public Domain Name"
  type        = string
  default     = ""
}

#AppGateway Variables
variable "appgw_name" {
  description = "Application Gateway Name"
  type        = string
  default     = null
}

variable "appgw_resource_group" {
  description = "Resource Group where application gateway is located."
  type        = string
  default     = null
}

variable "appgw_subnet_name" {
  description = "Subnet name where application gateway is located."
  type        = string
  default     = null
}

variable "appgw_vnet_name" {
  description = "Virtual Network where application gateway is located."
  type        = string
  default     = null
}

#VNET Gateway Variables

variable "vpn_gateway_enabled" {
  description = "Enabling this will VPN Gateway and components on Azure"
  type        = bool
  default     = false
}

variable "vpn_gateway_type" {
  description = "The type of the Virtual Network Gateway. Valid options are Vpn or ExpressRoute"
  default     = "Vpn"
}

variable "vpn_type" {
  description = "The routing type of the Virtual Network Gateway. Valid options are RouteBased or PolicyBased. Defaults to RouteBased"
  default     = "RouteBased"
}

variable "vpn_gw_sku" {
  description = "Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn_type and generation arguments"
  default     = "VpnGw1"
}

variable "enable_active_active" {
  description = "If true, an active-active Virtual Network Gateway will be created. An active-active gateway requires a HighPerformance or an UltraPerformance sku. If false, an active-standby gateway will be created. Defaults to false."
  default     = false
}

variable "enable_bgp" {
  description = "If true, BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway. Defaults to false"
  default     = false
}

variable "vpn_gw_generation" {
  description = "The Generation of the Virtual Network gateway. Possible values include Generation1, Generation2 or None"
  default     = "Generation1"
}


variable "bgp_asn_number" {
  description = "The Autonomous System Number (ASN) to use as part of the BGP"
  default     = "65515"
}

variable "bgp_peering_address" {
  description = "The BGP peer IP address of the virtual network gateway. This address is needed to configure the created gateway as a BGP Peer on the on-premises VPN devices. The IP address must be part of the subnet of the Virtual Network Gateway."
  default     = ""
}

variable "bgp_peer_weight" {
  description = "The weight added to routes which have been learned through BGP peering. Valid values can be between 0 and 100"
  default     = ""
}

variable "vpn_client_configuration" {
  type        = object({ address_space = string, certificate = string, vpn_client_protocols = list(string) })
  description = "Virtual Network Gateway client configuration to accept IPSec point-to-site connections"
  default     = null
}
