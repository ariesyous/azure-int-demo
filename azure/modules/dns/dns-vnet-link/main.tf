locals {
  extract_resource_name  = "${var.common_name_prefix}-${var.environment}-${var.name}-vnet-link"
}


resource "azurerm_private_dns_zone_virtual_network_link" "main" {
  name                  = local.extract_resource_name
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = var.registration_enabled
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    {
      environment = var.environment
    },
    var.tags,
  )
}