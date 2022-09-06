locals {
  resource_name = "${var.common_name_prefix}-${var.environment}-${var.name}-ddospp"
}

resource "azurerm_network_ddos_protection_plan" "network_ddos_protection_plan" {
  name                = local.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name

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