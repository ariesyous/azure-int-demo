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

variable "number" {
  description = "The count of the resource"
  default     = "001"
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

#Redis Variables
variable "capacity" {
  description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4"
  type        = number
  default     = 2
}

variable "family" {
  description = " The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)"
  type        = string
  default     = "C"
}

variable "sku_name" {
  description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium."
  type        = string
  default     = "Standard"
}

variable "patch_day_of_week" {
  description = "The Weekday name - possible values include Monday, Tuesday, Wednesday etc."
  type        = string
  default     = "Saturday"
}

variable "patch_start_hour_utc" {
  description = "The Start Hour for maintenance in UTC - possible values range from 0 - 23."
  type        = number
  default     = 23
}

variable "patch_maintenance_window" {
  description = "The ISO 8601 timespan which specifies the amount of time the Redis Cache can be updated. Defaults to PT5H."
  type        = string
  default     = "PT3H"
}

variable "enable_authentication" {
  description = "If set to false, the Redis instance will be accessible without authentication. Defaults to true."
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "Only available when using the Premium SKU The ID of the Subnet within which the Redis Cache should be deployed. This Subnet must only contain Azure Cache for Redis instances without any other type of resources. Changing this forces a new resource to be created."
  type        = string
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
