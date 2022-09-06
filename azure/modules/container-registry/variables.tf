# General variables 

variable "name" {
  description = "Name of the resource"
  type        = string
}

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

variable "resource_group_name" {
  description = "name of resource group name to create the the resource"
  type        = string
}

#acr variables
variable "sku" {
  description = "The SKU name of the container registry"
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Specifies whether the admin user is enabled"
  type        = string
  default     = false
}

variable "georeplication_locations" {
  description = "A list of Azure locations where the container registry should be geo-replicated."
  type        = list(string)
  default     = null
}

variable "roles" {
  description = "List of roles that should be assigned to Azure AD object_ids."
  type        = list(object({ object_id = string, role = string }))
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}


