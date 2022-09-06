locals {
  extract_security_group_name = "${var.number}-${var.environment}-cp-${var.common_name_prefix}-nsg"
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = lower("${local.extract_security_group_name}")
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rule
    content {
      name                       = security_rule.value.name
      description                = security_rule.value.description
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = length(security_rule.value.source_port_ranges) == 1 ? security_rule.value.source_port_ranges[0] : null
      source_port_ranges         = length(security_rule.value.source_port_ranges) < 2 ? [] : security_rule.value.source_port_ranges
      destination_port_range     = length(security_rule.value.destination_port_ranges) == 1 ? security_rule.value.destination_port_ranges[0] : null
      destination_port_ranges    = length(security_rule.value.destination_port_ranges) < 2 ? [] : security_rule.value.destination_port_ranges
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

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

#Wait for NSG Association to be deleted (API reports deletion before it is actually deleted)
resource "time_sleep" "wait_destroy" {
  depends_on = [azurerm_network_security_group.network_security_group]

  destroy_duration = "300s"
}


# Network Security Group association
resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.network_security_group.id

  depends_on = [azurerm_network_security_group.network_security_group,time_sleep.wait_destroy]
}
