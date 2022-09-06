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
  description = "Name of the resource"
  type        = string
}

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

#key-vault variables 

variable "tenant_id" {
  type    = string
  default = null
}

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "soft_delete_enabled" {
  type    = bool
  default = true
}

variable "enabled_for_disk_encryption" {
  type    = bool
  default = false
}

variable "soft_delete_retention_days" {
  type    = number
  default = 7
}
variable "purge_protection_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

# network policy variables 

# variable "default_action" {
#   type    = string
#   default = "Deny"
# }

# variable "bypass" {
#   type    = string
#   default = "AzureServices"
# }

# variable "ip_rules" {
#   type    = list(string)
#   default = []
# }

# variable "virtual_network_subnet_ids" {
#   type    = list(string)
#   default = []
# }

variable "enabled_for_template_deployment" {
  type        = string
  description = "Allow Azure Resource Manager to retrieve secrets from the Azure Key Vault"
  default     = true
}


# kv policy variables
variable "object_id" {
  type        = string
  description = "The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies."
}

variable "application_id" {
  type        = string
  description = "The object ID of an Application in Azure Active Directory."
  default     = null
}

variable "key_permissions" {
  type        = list(string)
  description = "List of key permissions."
  default = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
}

variable "certificate_permissions" {
  type        = list(string)
  description = "List of certificate permissions."
  default = [
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "SetIssuers",
    "Update",
    "Purge",
  ]
}

variable "storage_permissions" {
  type        = list(string)
  description = "List of storage permissions."
  default = [
    "Backup",
    "Delete",
    "DeleteSAS",
    "Get",
    "GetSAS",
    "List",
    "ListSAS",
    "Purge",
    "Recover",
    "RegenerateKey",
    "Restore",
    "Set",
    "SetSAS",
    "Update"
  ]
}

variable "random_id" {
  type    = string
  default = "23l4"
}