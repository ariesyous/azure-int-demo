# General variables 
variable "environment" {
  description = "The name for identifying the type of environment"
  type        = string
}

variable "location" {
  description = "The data center location where all resources will be put into."
  type        = string
}

variable "shared_name_prefix" {
  description = "The prefix used to name shared resources created."
  type        = string
}

variable "number" {
  description = "The count of the resource"
  default     = "001"
}

variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

# public ip variables 

variable "resource_prefix" {
  description = "The prefix used to name the resource created."
  type        = string
  default     = ""
}

variable "allocation_method" {
  description = "Defines the allocation method for this IP address. Possible values are Static or Dynamic."
  default     = "Static"
}
variable "sku" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
  default     = "Basic"
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

