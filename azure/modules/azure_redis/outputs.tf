output "redis_id" {
  value = azurerm_redis_cache.main.id
}

output "redis_hostname" {
  value = azurerm_redis_cache.main.hostname
}

output "redis_ssl_port" {
  value = azurerm_redis_cache.main.hostname
}

output "redis_port" {
  value = azurerm_redis_cache.main.port
}

output "redis_primary_access_key" {
  value = azurerm_redis_cache.main.primary_access_key
}

output "redis_secondary_access_key" {
  value = azurerm_redis_cache.main.secondary_access_key
}

output "redis_primary_connection_string" {
  value = azurerm_redis_cache.main.primary_connection_string
}

output "redis_secondary_connection_string" {
  value = azurerm_redis_cache.main.secondary_connection_string
}

output "redis_redis_configuration" {
  value = azurerm_redis_cache.main.redis_configuration
}
