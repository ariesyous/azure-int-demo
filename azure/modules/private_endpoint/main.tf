locals {
  private_endpoint_name  = "${var.environment}-${var.app}-${var.common_name_prefix}-private-endpoint"
  private_service_connection_name = "${var.environment}-${var.app}-${var.common_name_prefix}-private-endpoint-serviceconnection"
}
resource "azurerm_private_endpoint" "main" {
  name                = local.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = local.private_service_connection_name
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.subresource_names
    is_manual_connection           = var.is_manual_connection
  }
}