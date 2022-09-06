resource "azurerm_dns_zone" "zone_public" {
  name                = var.external_domain_name
  resource_group_name = var.resource_group
}
