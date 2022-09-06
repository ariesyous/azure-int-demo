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

variable "subnet_prefix" {
  description = "The prefix used to name all subnets created."
  type        = string
}


variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

# 3-subnet variables

variable "virtual_network_name" {
  description = "The name of the virtual network connecting all resources."
  type        = string
}

variable "address_prefix" {
  type        = string
  description = "(Deprecated in favour of address_prefixes) The address prefix to use for the subnet."
  default     = null
}

variable "address_prefixes" {
  type        = string
  description = "The address prefixes to use for the subnet."
  default     = ""
}

variable "delegation" {
  type = object({
    name = string
    service_delegation = object({
      name    = string
      actions = list(string)
    })
  })

  default = null
}

variable "service_endpoints" {
  type    = list(string)
  default = []
}

variable "enforce_private_link_endpoint_network_policies" {
  type        = bool
  description = "Enable or Disable network policies for the private link endpoint on the subnet."
  default     = false
}

variable "subnet_service_endpoints" {
  description = "The list of service endpoints."
  default     = []
}



