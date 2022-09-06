
#---------------------------------------
# Virtual Network Gateway Connection
#---------------------------------------
resource "azurerm_virtual_network_gateway_connection" "az-hub-onprem" {
  count                           = var.gateway_connection_type == "ExpressRoute" ? 1 : length(var.local_networks)
  name                            = var.gateway_connection_type == "ExpressRoute" ? "localgw-expressroute-connection" : "localgw-connection-${var.local_networks[count.index].local_gw_name}"
  resource_group_name             = data.azurerm_resource_group.rg.name
  location                        = data.azurerm_resource_group.rg.location
  type                            = var.gateway_connection_type
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id        = var.gateway_connection_type != "ExpressRoute" ? azurerm_local_network_gateway.localgw[count.index].id : null
  express_route_circuit_id        = var.gateway_connection_type == "ExpressRoute" ? var.express_route_circuit_id : null
  peer_virtual_network_gateway_id = var.gateway_connection_type == "Vnet2Vnet" ? var.peer_virtual_network_gateway_id : null
  shared_key                      = var.gateway_connection_type != "ExpressRoute" ? var.local_networks[count.index].shared_key : null
  connection_protocol             = var.gateway_connection_type == "IPSec" && var.vpn_gw_sku == ["VpnGw1", "VpnGw2", "VpnGw3", "VpnGw1AZ", "VpnGw2AZ", "VpnGw3AZ"] ? var.gateway_connection_protocol : null

  dynamic "ipsec_policy" {
    for_each = var.local_networks_ipsec_policy != null ? [true] : []
    content {
      dh_group         = var.local_networks_ipsec_policy.dh_group
      ike_encryption   = var.local_networks_ipsec_policy.ike_encryption
      ike_integrity    = var.local_networks_ipsec_policy.ike_integrity
      ipsec_encryption = var.local_networks_ipsec_policy.ipsec_encryption
      ipsec_integrity  = var.local_networks_ipsec_policy.ipsec_integrity
      pfs_group        = var.local_networks_ipsec_policy.pfs_group
      sa_datasize      = var.local_networks_ipsec_policy.sa_datasize
      sa_lifetime      = var.local_networks_ipsec_policy.sa_lifetime
    }
  }
  tags = merge({ "ResourceName" = var.gateway_connection_type == "ExpressRoute" ? "localgw-expressroute-connection" : "localgw-connection-${var.local_networks[count.index].local_gw_name}" }, var.tags, )
}