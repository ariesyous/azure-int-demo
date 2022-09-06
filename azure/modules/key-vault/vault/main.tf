locals {
  extract_resource_name = "${var.environment}-${var.common_name_prefix}-kv"
  kv = substr(local.extract_resource_name, 0, 17)
  kv_name = "${local.kv}-${var.random_id}"
}

resource "azurerm_key_vault" "key_vault" {
  name                            = local.kv_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = var.tenant_id
  sku_name                        = var.sku_name
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  enabled_for_template_deployment = var.enabled_for_template_deployment


  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    {
      environment = var.environment
    },
    var.tags,
  )

  network_acls {
    default_action = "Allow"
    bypass = "AzureServices"
  }

  # network_acls {
  #   default_action             = var.default_action
  #   bypass                     = var.bypass
  #   ip_rules                   = var.ip_rules
  #   virtual_network_subnet_ids = var.virtual_network_subnet_ids
  # }
}

resource "time_sleep" "wait_for_keyvault" {
  create_duration = "180s"

  depends_on = [azurerm_key_vault.key_vault]
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  key_vault_id            = azurerm_key_vault.key_vault.id
  tenant_id               = var.tenant_id
  object_id               = var.object_id
  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
  storage_permissions     = var.storage_permissions

  depends_on = [time_sleep.wait_for_keyvault]
}

resource "time_sleep" "wait_for_keyvault_policy" {
  create_duration = "120s"

  depends_on = [azurerm_key_vault_access_policy.key_vault_access_policy]
}