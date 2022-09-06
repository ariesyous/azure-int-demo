variable "clientID" {}
variable "clientsecret" {}
variable "tenantID" {}
variable "subscriptionId" {}

variable "subscriptionName_dev" {
  default = "Development"
}

variable "vpn_resource_group" {
  default = "one-common-dev-rg"
}

variable "vpn_vnet_name" {
  default = "one-vpn-common-dev-vnet"
}

variable "target_resource_group" {}

variable "target_vnet_name" {}
variable "name" {}