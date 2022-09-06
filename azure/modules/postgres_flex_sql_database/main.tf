locals {
  postgres_database_name  = "${var.common_name_prefix}-${var.environment}-flex-psqldb"
}

resource "azurerm_postgresql_flexible_server_database" "main" {
  name                = local.postgres_database_name
  server_id           = var.postgres_flex_server_id
  charset             = var.charset
  collation           = var.collation
}