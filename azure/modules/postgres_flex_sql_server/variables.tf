# General variables 
variable "environment" {
  description = "The name for identifying the type of environment"
  type        = string
}

variable "location" {
  description = "The data center location where all resources will be put into."
  type        = string
}

variable "common_name_prefix" {
  description = "The prefix used to name all resources created."
  type        = string
}

variable "name" {
  description = "The resoursce name to allocate."
  type        = string
}

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

#postgres Server Variables
variable "sku_name" {
  description = "Specifies the SKU Name for this Pos tgreSQL Server. The name of the SKU, follows the tier + family + cores pattern (e.g. B_Gen4_1, GP_Gen5_8). For more information see the product documentation (https://docs.microsoft.com/en-us/rest/api/postgresql/flexibleserver(preview)/servers/create#skutier)"
  type        = string
  default     = "B_Standard_B2s"
}
 
variable "administrator_login" {
  description = "The Administrator Login for the PostgreSQL Server. Required when create_mode is Default. Changing this forces a new resource to be created."
  type        = string
}

variable "administrator_login_password" {
  description = "he Password associated with the administrator_login for the PostgreSQL Server. Required when create_mode is Default."
  type        = string
  default     = null
}

variable "postgres_version" {
  description = "Specifies the version of PostgreSQL to use. Valid values are 11, 12, 13 and 14. Changing this forces a new resource to be created."
  type        = string
  default     = "13"
}

variable "postgres_virtual_network_id" {
  description = "The ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "postgres_delegated_subnet_id" {
  description = "The ID of the virtual network subnet to create the PostgreSQL Flexible Server. The provided subnet should not have any other resource deployed in it and this subnet will be delegated to the PostgreSQL Flexible Server, if not already delegated. Changing this forces a new PostgreSQL Flexible Server to be created."
  type        = string
  default     = null
}

variable "storage_mb" {
  description = "Max storage allowed for a server. Possible values are between 5120 MB(5GB) and 1048576 MB(1TB) for the Basic SKU and between 5120 MB(5GB) and 16777216 MB(16TB) for General Purpose/Memory Optimized SKUs. For more information see the product documentation. (https://docs.microsoft.com/en-us/rest/api/postgresql/servers/create#StorageProfile)"
  type        = number
  default     = 32768
}

variable "backup_retention_days" {
  description = "Backup retention days for the server, supported values are between 7 and 35 days."
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not support for the Basic tier. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "auto_grow_enabled" {
  description = "Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is true."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether or not public network access is allowed for this server."
  type        = bool
  default = false
}

variable "ssl_enforcement_enabled" {
  description = "Specifies if SSL should be enforced on connections. Possible values are true and false."
  type        = bool
  default     = true
}

variable "ssl_minimal_tls_version_enforced" {
  description = "The mimimun TLS version to support on the sever. Possible values are TLSEnforcementDisabled, TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2."
  type        = string
  default     = "TLSEnforcementDisabled"
}

variable "identity_type" {
  description = "The Type of Identity which should be used for this PostgreSQL Server. At this time the only possible value is SystemAssigned."
  type        = string
  default     = "SystemAssigned"
}
variable "registration_enabled" {
  description = " Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled? Defaults to false."
  type = bool
  default = false
}

variable "require_secure_transport" {
  description = "Is secured transport required while connect to the DB server?"
  type = string
  default = "off"
}
