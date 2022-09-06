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
  description = "Name of the resource"
  type        = string
}

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

# nic variables
variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where this Network Interface should be located in."
}
variable "private_ip_address_allocation" {
  description = "allocation method used for the Private IP Address.Possible values are Dynamic and Static"
  type        = string
  default     = "Dynamic"
}
variable "static_public_ip" {
  type        = string
  description = "Assign a public ip to the vm. Default true"
  default     = ""
}
# nic to nsg group association
# variable "network_security_group_id" {
#   description = "nsg group id to associate with nic"
#   type        = string
# }

#MarketPlace VM agreement variables

variable "plans" {
  type = list(object({
    name      = string
    product   = string
    publisher = string
    plan      = string
  }))
  default = []
}


# vm variables

variable "admin_username" {
  type        = string
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "size" {
  type        = string
  description = "The SKU which should be used for this Virtual Machine, such as Standard_F2."
  default     = "Standard_F2"
}

variable "source_image_reference" {
  type = list(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
  default = []
}

variable "os_disk" {
  type = object({
    caching                   = string
    storage_account_type      = string
    disk_encryption_set_id    = string
    disk_size_gb              = string
    name                      = string
    write_accelerator_enabled = bool
  })
}
variable "admin_ssh_key" {
  type = list(object({
    public_key = string
    username   = string
  }))
  default = []
}
variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}
