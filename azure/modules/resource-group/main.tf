
locals {
  resource_group_name = "${var.common_name_prefix}-${var.name}-rg"
}

resource "azurerm_resource_group" "main" {
  name     = local.resource_group_name
  location = var.location
  tags = merge(
    {
      Name = format("%s", var.name)
    },
    {
      environment = var.environment
    },
    var.tags,
  )
}

