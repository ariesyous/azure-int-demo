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


variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}



#Metric Alert Variables


# variable "aks_nams" {
#   description = "AKS Cluster Name"
#   type        = string
# }


variable "aks_id" {
  description = "AKS Cluster ID"
  type        = string
}


variable "ag_id" {
  description = "Action Group ID."
  type        = string
}

variable "cms_ag_id" {
  description = "CMS Application Gateway ID."
  type        = string
}

variable "one_ag_id" {
  description = "One Application Gateway ID."
  type        = string
}

variable "threshold_4xx" {
  description = "Threshold for 4xx alerts."
  type        = number
}

variable "threshold_5xx" {
  description = "Threshold for 5xx alerts.."
  type        = number
}

variable "frequency" {
  description = "The evaluation frequency of this Metric Alert, represented in ISO 8601 duration format. Possible values are PT1M, PT5M, PT15M, PT30M and PT1H. Defaults to PT1M."
  type        = string
}

variable "window_size" {
  description = "The period of time that is used to monitor alert activity, represented in ISO 8601 duration format. This value must be greater than frequency. Possible values are PT1M, PT5M, PT15M, PT30M, PT1H, PT6H, PT12H and P1D. Defaults to PT5M"
  type        = string
}