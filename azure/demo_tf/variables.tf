variable "client_secret" {
  type = string
}

variable "resource_group_name" {
  type = string
  default = null
}

variable "shared_name_prefix"{
  type = string
  default = "demo"
}

variable "client_id" {
  type = string
}

variable "aks_public_ssh_key" {
  type = string
  default = null
}

variable "postgres_administrator_login_password" {
  type    = string
  default = null
}

variable "postgres_administrator_login" {
  type = string
  default = "postgres"
}

variable "redis_enable_non_ssl_port" {
  description = "Enable the Redis non-SSL port (6379) - disabled by default."
  type        = bool
  default     = true
}

variable "name" {
  type = string
  default = "Codepipes"
}

variable "location" {
  type = string
  default = "eastus"
}

variable "environment" {
  type = string
  default = "test"
}

variable "common_name_prefix" {
  type = string
  default = "test"
}

variable "sku_public_ip" {
  type = string
  default = "Standard"
}

variable "public_ip_allocation_method" {
  type = string
  default = "Static"
}

variable "private_ip_address_agic" {
  type = string
  default = "10.0.17.25"
}

#AKS
variable "aks_dns_prefix" {
  type = string
  default = "cldcvr-test"
}

variable "aks_admin_username" {
  type = string
  default = "codepipes"
}

variable "aks_service_cidr" {
  type = string
  default = "10.40.16.0/24"
}

variable "aks_dns_service_ip" {
  type = string
  default = "10.40.16.7"
}

variable "aks_docker_bridge_cidr" {
  type = string
  default = "172.16.3.1/24"
}

variable "aks_role_based_access_control" {
  type = bool
  default = true
}

variable "aks_azure_active_directory_enabled" {
  type = bool
  default = true
}

variable "aks_enable_auto_scaling" {
  type = bool
  default = true
}

variable "node_size" {
  default     = "Standard_D2s_v3"
  description = "The default virtual machine size for the Kubernetes agents"
  type        = string
}

variable "aks_node_min_count" {
  type = number
  default = 2
}

variable "aks_node_max_count" {
  type = number
  default = 5
}

variable "aks_kubernetes_version" {
  type = string
  default = "1.23.8"
}

variable "aks_max_pods" {
  type = number
  default = 150
}

#Redis
variable "redis_capacity" {
  type = number
  default = 1
}

variable "redis_family" {
  type = string
  default = "P"
}

variable "redis_sku_name" {
  type = string
  default = "Premium"
}

variable "redis_enable_authentication" {
  type = bool
  default = false
}

variable "redis_version" {
  type = number
  default = 4
}

variable "redis_patch_day_of_week" {
  type = string
  default = "Saturday"
}

variable "redis_patch_start_hour_utc" {
  type = number
  default = 23
}

variable "redis_patch_maintenance_window" {
  type = string
  default = "PT5H"
}

#Postgres Server
variable "postgres_sku_name" {
  type = string
  default = "GP_Gen5_2"
}

variable "postgres_version" {
  type = string
  default = "9.6"
}

variable "postgres_storage_mb" {
  type = number
  default = 5120
}

variable "postgres_backup_retention_days" {
  type = number
  default = 7
}

variable "postgres_geo_redundant_backup_enabled" {
  type = bool
  default = false
}

variable "postgres_auto_grow_enabled" {
  type = bool
  default = false
}

variable "postgres_public_network_access_enabled" {
  type = bool
  default = false
}

variable "postgres_ssl_enforcement_enabled" {
  type = bool
  default = false
}

variable "postgres_identity_type" {
  type = string
  default = "SystemAssigned"
}

variable "postgres_db_charset" {
  type = string
  default = "UTF8"
}

variable "postgres_db_collation" {
  type = string
  default = "English_United States.1252"
}

#Postgres Private Link Rule
variable "private_endpoint_is_manual_connection" {
  type = bool
  default = false
}


#Storage Account Variables
variable "storage_account_kind" {
  type = string
  default = "StorageV2"
}

variable "storage_account_tier" {
  type = string
  default = "Standard"
}

variable "storage_access_tier" {
  type = string
  default = "Hot"
}

variable "storage_account_replica" {
  type = string
  default = "GRS"
}

variable "storage_min_tls_version" {
  type = string
  default = "TLS1_2"
}


#Storage Container Variables
variable "storage_container_name" {
  type = string
  default = "bucket-data"
}
