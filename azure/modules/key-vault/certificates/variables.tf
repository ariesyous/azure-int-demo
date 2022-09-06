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

#key-vault variables 

variable "key_vault_id" {
  type    = string
  default = null
}

variable "certificate_p12" {
  type    = string
  default = null
}

variable "certificate_p12_password" {
  type    = string
  default = ""
}

variable "private_key" {
  type    = string
  default = ""
}



