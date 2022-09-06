locals {
  extract_azuread_name = "${var.common_name_prefix}-${var.environment}-${var.name}-azuread-app"
}

# Creating an application
resource "azuread_application" "one_generic" {
  name = local.extract_azuread_name
}

# Creating service principal
resource "azuread_service_principal" "service_principal" {
  application_id = azuread_application.one_generic.application_id
}

# Generate random password
resource "random_string" "service_principal_random_password" {
  length           = 20
  special          = true
  override_special = "!@#$&*()-_=+[]{}<>:?"
}

# creating the service principal password

resource "azuread_service_principal_password" "service_principal_password" {
  service_principal_id = azuread_service_principal.service_principal.id
  value                = random_string.service_principal_random_password.result
  end_date_relative    = "8760h"

  lifecycle {
    ignore_changes = ["value"]
  }
}

# Save secret in vault
resource "azurerm_key_vault_secret" "key_vault_secret" {
  name         = var.secret_name_saving_pwd_vault
  value        = random_string.service_principal_random_password.result
  key_vault_id = var.key_vault_id_storing_secrets

  lifecycle {
    ignore_changes = ["value"]
  }
}

################################################

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id            = var.key_vault_id
  tenant_id               = var.tenant_id
  object_id               = azuread_application.one_generic.id
  application_id          = azuread_service_principal.service_principal.id
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
  storage_permissions     = var.storage_permissions
}
