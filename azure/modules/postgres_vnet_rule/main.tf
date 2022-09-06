locals {
  postgres_vnet_rule_name  = "${var.common_name_prefix}-${var.environment}-${var.name}-postgres-vnet-rule"
}


resource "azurerm_postgresql_virtual_network_rule" "example" {
  name                                 = local.postgres_vnet_rule_name
  resource_group_name                  = var.resource_group_name
  server_name                          = var.postgres_server_name
  subnet_id                            = var.postgres_subnet_id
  ignore_missing_vnet_service_endpoint = var.ignore_missing_vnet_service_endpoint
}