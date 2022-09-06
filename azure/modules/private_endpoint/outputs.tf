output "name" {
  value = azurerm_private_endpoint.main.name
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.main.id
}

output "private_service_connection" {
  value = azurerm_private_endpoint.main.private_service_connection[0].private_ip_address
}

