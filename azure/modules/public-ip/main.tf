locals {
  extract_public_ip_name = "${var.number}-${var.shared_name_prefix}-${var.environment}-pip"
}
resource "azurerm_public_ip" "public_ip" {
  name                = local.extract_public_ip_name 
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
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


