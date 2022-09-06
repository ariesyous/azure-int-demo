locals {
  extract_subnet_name = "001-${var.subnet_prefix}-snet"
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = local.extract_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["${var.address_prefixes}"]

  dynamic "delegation" {
    for_each = var.delegation == null ? [] : ["delegation"]
    content {
      name = var.delegation.name

      service_delegation {
        name    = var.delegation.service_delegation.name
        actions = var.delegation.service_delegation.actions
      }
    }
  }

  service_endpoints = var.service_endpoints

  enforce_private_link_endpoint_network_policies = var.enforce_private_link_endpoint_network_policies
}