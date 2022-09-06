resource "azurerm_private_dns_zone" "zone_private" {
  name                = var.internal_domain_name
  resource_group_name = var.resource_group
}
