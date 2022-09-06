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


variable "application_id" {
  description = "Application ID of the Service Principal"
  type        = string
}


variable "aks_id" {
  description = "AKS Cluster ID"
  type        = string
}


variable "ag_id" {
  description = "Action Group ID."
  type        = string
}

variable "node_cpu_threshold" {
  description = "Node CPU Percentage threshold."
  type        = number
}

variable "node_memory_threshold" {
  description = "Node Memory Percentage threshold."
  type        = number
}

variable "container_cpu_threshold" {
  description = "Container CPU Percentage threshold."
  type        = number
}

variable "container_memory_threshold" {
  description = "Container Memory Percentage threshold."
  type        = number
}

variable "pod_oom_count" {
  description = "Number of OOM Pods threshold."
  type        = number
}

variable "pod_restart_count" {
  description = "Number of pods restart count threshold ."
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

