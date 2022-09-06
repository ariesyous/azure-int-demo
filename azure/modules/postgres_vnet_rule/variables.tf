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

#VNET Rule Variables
variable "postgres_server_name" {
  description = "Specifies the postgres server where database needs to be created."
  type        = string
}

variable "postgres_subnet_id" {
  description = "The ID of the subnet that the PostgreSQL server will be connected to."
  type        = string
}

variable "ignore_missing_vnet_service_endpoint" {
  description = "Should the Virtual Network Rule be created before the Subnet has the Virtual Network Service Endpoint enabled? Defaults to false."
  type        = bool
  default     = true
}


