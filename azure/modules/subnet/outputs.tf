output "subnet_name" {
  description = "The name of the subnet created"
  value       = azurerm_subnet.subnet.name
}

output "subnet_id" {
  description = "The id of the subnet created"
  value       = azurerm_subnet.subnet.id
}

output "resource_group_name" {
  description = "resource group name"
  value       = azurerm_subnet.subnet.resource_group_name
}

output "address_prefixes" {
  description = "value of subnet prefix"
  value       = azurerm_subnet.subnet.address_prefixes
}
