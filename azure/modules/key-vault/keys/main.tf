locals {
  extract_resource_name = "${var.common_name_prefix}-${var.environment}-keys"
  key_name = substr(local.extract_resource_name, 0, 23)
}

resource "azurerm_key_vault_key" "main" {
  name         = local.key_name
  key_vault_id = var.keyvault_id
  key_type     = var.key_type
  key_size     = var.key_size

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}