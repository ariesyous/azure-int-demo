output "client_id" {
  value = azuread_application.one_generic.application_id
}

output "client_secret" {
  value = azuread_service_principal_password.service_principal_password.value
}

output "principal_id" {
  value = azuread_service_principal.service_principal.object_id
}

output "id" {
  value = azurerm_key_vault_access_policy.key_vault_access_policy.id
}
