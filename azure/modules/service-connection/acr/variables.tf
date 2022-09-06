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

# module variables
variable "project_name" {
  type        = string
  default     = "ONE Super App"
  description = "Name of the Project"
}


variable "authorization_type" {
  type        = string
  description = "The authentication method used to authenticate on the container registry"
  default     = "AzureSubscription"
}
variable "subscription_id" {
  type        = string
  description = "The id of the Azure subscription."
}
variable "subscription_name" {
  type        = string
  description = "The name of the Azure subscription."
}
variable "tenant_id" {
  type        = string
  description = "The id of the tenant used by the subscription"
}
variable "resourcegroup_id" {
  type        = string
  description = " The resource group id, to which the container registry is deployed"
}
variable "acr_name" {
  type        = string
  description = "The name of the container registry"
}