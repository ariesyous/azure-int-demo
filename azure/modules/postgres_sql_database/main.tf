locals {
  postgres_database_name  = "${var.environment}-${var.common_name_prefix}-${var.number}-postgresqldb"
}

resource "azurerm_postgresql_database" "main" {
  name                = local.postgres_database_name
  resource_group_name = var.resource_group_name
  server_name         = var.postgres_server_name
  charset             = var.charset
  collation           = var.collation
}