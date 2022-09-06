locals {
  extract_resource_name = "001-${var.environment}-${var.common_name_prefix}-gw-i-vnet"
}
#---------------------------
# Local Network Gateway
#---------------------------
resource "azurerm_local_network_gateway" "localgw" {
  name                = local.extract_resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  gateway_address     = var.local_gateway_address
  address_space       = var.local_address_space

  dynamic "bgp_settings" {
    for_each = var.local_bgp_settings != null ? [true] : []
    content {
      asn                 = var.local_bgp_settings[count.index].asn_number
      bgp_peering_address = var.local_bgp_settings[count.index].peering_address
      peer_weight         = var.local_bgp_settings[count.index].peer_weight
    }
  }
  tags = merge({ "ResourceName" = "localgw-${var.local_gw_name}" }, var.tags, )
}
