locals {
  redis_resource_name  = "${var.environment}-${var.common_name_prefix}-${var.number}-redis"
}

resource "azurerm_redis_cache" "main" {
  name                = local.redis_resource_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  enable_non_ssl_port = var.enable_non_ssl_port

  redis_version         = var.redis_version
  subnet_id             = var.subnet_id

  patch_schedule {
      day_of_week        = var.patch_day_of_week
      start_hour_utc     = var.patch_start_hour_utc
      maintenance_window = var.patch_maintenance_window
  }

  redis_configuration {
    enable_authentication = var.enable_authentication
  }

  lifecycle {
    ignore_changes = [redis_configuration.0.rdb_storage_connection_string]
  }
}