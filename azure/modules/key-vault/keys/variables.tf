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

variable "keyvault_id" {
  type    = string
  default = null
}

variable "key_type" {
  type    = string
  default = "RSA"
}

variable "key_size" {
  type    = number
  default = 4096
}