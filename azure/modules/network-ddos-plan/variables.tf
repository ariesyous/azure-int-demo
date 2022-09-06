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

#ddospp variables 

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}