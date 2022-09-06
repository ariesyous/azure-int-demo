locals {
  extract_resource_name = "${var.common_name_prefix}-${var.environment}-${var.name}-actiongroup"
}

resource "azurerm_monitor_action_group" "email" {
  name                = local.extract_resource_name
  resource_group_name = var.resource_group_name
  short_name          = "ActionGroup"

  email_receiver {
    name          = "email"
    email_address = var.email
  }
}