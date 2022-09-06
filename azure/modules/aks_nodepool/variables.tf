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


#nodepool variables 
variable "additional_node_pools" {
  type = map(object({
    name                           = string
    node_count                     = number
    vm_size                        = string
    node_os                        = string
    max_pods                       = number
    os_disk_size_gb                = number
    vnet_subnet_id                 = string
    enable_auto_scaling            = bool
    cluster_auto_scaling_min_count = number
    cluster_auto_scaling_max_count = number
  }))
}
