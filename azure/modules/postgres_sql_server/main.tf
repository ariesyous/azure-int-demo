locals {
  postgres_server_name  = "${var.environment}-${var.common_name_prefix}-${var.number}-postgresqlsvr"
  postgres_password     = var.administrator_login_password != null? var.administrator_login_password : random_password.password.result
}

resource "random_password" "password" {
  length           = 16
  min_lower = 5
  min_upper = 5
  min_numeric = 4
  special          = true
  override_special = "!#$%?"
}

resource "azurerm_postgresql_server" "main" {
  name                = lower(local.postgres_server_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.administrator_login
  administrator_login_password = local.postgres_password

  sku_name   = var.sku_name
  version    = var.postgres_version
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  auto_grow_enabled            = var.auto_grow_enabled

  public_network_access_enabled    = var.public_network_access_enabled
  ssl_enforcement_enabled          = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced = var.ssl_minimal_tls_version_enforced

  identity {
      type = var.identity_type
  }
}