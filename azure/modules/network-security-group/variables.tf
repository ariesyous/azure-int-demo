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

variable "number" {
  description = "The count of the resource"
  default     = "001"
}

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

variable "security_rule" {
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

variable "tags" {
  description = "The tags to associate with your network security group."
  type        = map
  default     = {}
}

# nsg association 
variable "subnet_id" {
  description = "subnet id for which for attaching nsg"
  type        = string
}

