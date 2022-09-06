locals {
  postgres_server_name   = "${var.common_name_prefix}-${var.environment}-flex-psqlsvr"
  postgres_dns_zone_name = "${var.common_name_prefix}-${var.environment}-psqlsvr-dns"
  postgres_password      = var.administrator_login_password != null? var.administrator_login_password : random_password.password.result
  depends_on_var         = var.postgres_virtual_network_id != null ? 1 : 0
}

resource "random_password" "password" {
  length           = 16
  special          = true
}

resource "azurerm_private_dns_zone" "main" {

  name                = "${var.common_name_prefix}.${var.environment}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "main" {

  name                  = "${var.common_name_prefix}-${var.environment}VnetZone.com"
  private_dns_zone_name = "${var.common_name_prefix}.${var.environment}.postgres.database.azure.com"
  virtual_network_id    = var.postgres_virtual_network_id
  resource_group_name   = var.resource_group_name
  registration_enabled  = var.registration_enabled

}


resource "azurerm_postgresql_flexible_server" "main" {
  name                = lower(local.postgres_server_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  administrator_login          = var.administrator_login
  administrator_password       = local.postgres_password
  delegated_subnet_id          = var.postgres_delegated_subnet_id
  private_dns_zone_id          = var.postgres_virtual_network_id != null ? azurerm_private_dns_zone.main.id : null

  sku_name   = var.sku_name
  version    = var.postgres_version
  storage_mb = var.storage_mb

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  lifecycle {
      ignore_changes = [
        zone,
        high_availability.0.standby_availability_zone,
      ]
  }

}

resource "azurerm_postgresql_flexible_server_configuration" "example" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.main.id
  value     = var.require_secure_transport
}