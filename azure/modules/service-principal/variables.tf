# General Variables
variable "environment" {
  description = "The name for identifying the type of environment"
  type        = string
}
variable "name" {
  description = "The name of the virtual network connecting all resources."
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

#secrets storing in key vault

variable "secret_name_saving_pwd_vault" {
  description = "name of the secret to be stored in vault"
  type        = string
}

variable "key_vault_id_storing_secrets" {
  description = "key vault id where you will be storing the secrets"
  type        = string
}

###############################################

#kv variables
variable "key_vault_id" {
  type        = string
  description = "Specifies the id of the Key Vault resource."
}

variable "tenant_id" {
  type        = string
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  default     = null
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
    "backup",
    "create",
    "decrypt",
    "delete",
    "encrypt",
    "get",
    "import",
    "list",
    "purge",
    "recover",
    "restore",
    "sign",
    "unwrapKey",
    "update",
    "verify",
    "wrapKey",
  ]
}

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions."
  default = [
    "backup",
    "delete",
    "get",
    "list",
    "purge",
    "recover",
    "restore",
    "set",
  ]
}

variable "certificate_permissions" {
  type        = list(string)
  description = "List of certificate permissions."
  default = [
    "create",
    "delete",
    "deleteissuers",
    "get",
    "getissuers",
    "import",
    "list",
    "listissuers",
    "managecontacts",
    "manageissuers",
    "setissuers",
    "update",
  ]
}

variable "storage_permissions" {
  type        = list(string)
  description = "List of storage permissions."
  default = [
    "backup",
    "delete",
    "deletesas",
    "get",
    "getsas",
    "list",
    "listsas",
    "purge",
    "recover",
    "regeneratekey",
    "restore",
    "set",
    "setsas",
    "update"
  ]
}
