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

variable "virtual_network_id"{
    type=string
    default= ""
    description= "The ID of the Virtual Network that should be linked to the DNS Zone"
}

variable "registration_enabled"{
    type= bool
    default= false
    description= "Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled"
}

variable "private_dns_zone_name"{
    type= string
    default= ""
    description= "The name of the Private DNS zone"

}
