data "azurerm_dns_zone" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
}

output "zone_id" {
  value = data.azurerm_dns_zone.main.id
}

output "zone_name" {
  value = data.azurerm_dns_zone.main.name
}
variable "resource_group_name" {}
variable "name" {}