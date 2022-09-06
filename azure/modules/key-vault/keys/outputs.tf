output "id" {
  value = azurerm_key_vault_key.main.id
}

output "key_name" {
  value = local.key_name
}