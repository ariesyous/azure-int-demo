output "name" {
  value = azurerm_postgresql_flexible_server.main.name
}

output "postgres_server_id" {
  value = azurerm_postgresql_flexible_server.main.id
}

output "postgres_server_fqdn" {
  value = azurerm_postgresql_flexible_server.main.fqdn
}

output "postgres_server_public_network_access_enabled" {
  value = azurerm_postgresql_flexible_server.main.public_network_access_enabled
}


output "postgres_password" {
  value     = local.postgres_password
  sensitive = true
}
