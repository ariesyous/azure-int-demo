locals {
  resource_name = "${var.name}-${var.environment}-cdn-profile"
}
resource "azurerm_cdn_profile" "cdn_profile" {
  count               = var.enabled_cdn == true ? 1 : 0
  name                = local.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
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