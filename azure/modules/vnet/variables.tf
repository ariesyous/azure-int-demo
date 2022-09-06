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

variable "shared_name_prefix" {
  description = "The prefix used to name shared resources created."
  type        = string
}

variable "number" {
  description = "The count of the resource"
  default     = "001"
}

variable "resource_group_name" {
  description = "name of resource group name to create the the resource"
  type        = string
}
# 2-vnet variables
variable "dns_servers" {
  description = "The address space that is used the virtual network. You can supply more than one address space."
  type        = list
  default     = []
}
variable "address_space" {
  description = "The address space of the virtual network connecting all resources."
  type        = list(string)
}

variable "tags" {
  description = "the tags to associate with your network and subnets."
  type        = map(string)
}

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })

  default = null
}

