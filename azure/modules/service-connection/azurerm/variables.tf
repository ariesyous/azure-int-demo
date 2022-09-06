# General variables 
variable "name" {
  description = "Name of the resource"
  type        = string
}
variable "environment" {
  description = "The name for identifying the type of environment"
  type        = string
}

variable "common_name_prefix" {
  description = "The prefix used to name all resources created."
  type        = string
}

# Azurerm service connection variables 

variable "project_name" {
  type        = string
  default     = "ONE Super App"
  description = "Name of the Project"
}
variable "azurerm_spn_tenantid" {
  type        = string
  description = " The tenant id if the service principal"
}
variable "azurerm_subscription_id" {
  type        = string
  description = "The subscription Id of the Azure targets"
}
variable "azurerm_subscription_name" {
  type        = string
  description = "The subscription Name of the targets"
}
variable "serviceprincipalid" {
  type        = string
  description = "The service principal application Id"
}
variable "serviceprincipalkey" {
  type        = string
  description = "The service principal secret"
}