output "id" {
  description = "The Container Registry ID"
  value       = azurerm_container_registry.main.id
}

output "login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.main.login_server
}
output "name" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.main.name
}