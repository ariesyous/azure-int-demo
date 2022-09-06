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
  description = "Name of the resources"
  type        = string
}

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

variable "tags" {
  type = map
}

variable "template_file" {
  description = "Name of the templatized json file for dashboard creation."
  type        = string
}

variable "aks_resource_id" {
  description = "ID of AKS to be passed to the template file."
  type        = string
}

variable "ingress_resource_id" {
  description = "ID of AppGateway Ingress to be passed to the template file."
  type        = string
}


variable "cregistry_resource_id" {
  description = "ID of Container Registry to be passed to the template file."
  type        = string
}
