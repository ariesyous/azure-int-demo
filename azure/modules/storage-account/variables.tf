# General Variables
variable "environment" {
  description = "The name for identifying the type of environment"
  type        = string
}
variable "name" {
  description = "Name of the resource"
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

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

variable "random_id" {
  description = "Random ID for unique resource name."
  type        = string
}


#storage account variables

variable "account_replica" {
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type        = string
}

variable "account_kind" {
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "StorageV2"
}
variable "account_tier" {
  description = "The Azure storage account tier."
  type        = string
  default     = "Standard"
}
variable "access_tier" {
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
  default     = "Hot"
}

variable "enable_https_traffic_only" {
  description = "flag which forces HTTPS if enabled, see here for more information. Defaults to true."
  type        = bool
  default     = "true"
}
variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2"
  default     = "TLS1_2"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "assign_identity" {
  description = "Set to true to enable system-assigned managed identity, or false to disable it."
  default     = true
}

variable "soft_delete_retention" {
  description = "Number of retention days for soft delete. If set to null it will disable soft delete all together."
  default     = 30
}
variable "enable_blob_public_access" {
  description = "Boolean flag which controls if advanced threat protection is enabled.enable it when we want to make container public"
  type        = bool
  default     = false
}
variable "default_action" {
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow"
  type        = string
  default     = "Deny"
}

variable "network_rules" {
  description = "Network rules restricting access to the storage account."
  type = object({
    default_action = string,
    bypass         = list(string),
    ip_rules       = list(string),
    subnet_ids     = list(string)
  })
  default = null
}





