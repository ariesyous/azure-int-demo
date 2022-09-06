variable "environment" {
  description = "The name for identifying the type of environment"
  type        = string
}

variable "common_name_prefix" {
  description = "The prefix used to name all resources created."
  type        = string
}

variable "subscriptionId" {}
variable "subscriptionNAME" {}
variable "clusterID" {}
variable "tenantID" {}
variable "connName" {}
variable "aksHost" {}
variable "username" {}
variable "PAT" {}