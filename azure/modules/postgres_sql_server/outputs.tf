output "name" {
  value = azurerm_postgresql_server.main.name
}

output "postgres_server_id" {
  value = azurerm_postgresql_server.main.id
}

output "postgres_server_fqdn" {
  value = azurerm_postgresql_server.main.fqdn
}

output "postgres_server_principal_id" {
  value = azurerm_postgresql_server.main.identity[0].principal_id
}

output "postgres_server_tenant_id" {
  value = azurerm_postgresql_server.main.identity[0].tenant_id
}

output "postgres_password" {
  value     = local.postgres_password
  sensitive = true
}
