output "source_id" {
  value = azurerm_virtual_network_peering.virtual_network_peering_source.id
}

output "target_id" {
  value = azurerm_virtual_network_peering.virtual_network_peering_target.id
}

output "source_name" {
  value = azurerm_virtual_network_peering.virtual_network_peering_source.name
}

output "target_name" {
  value = azurerm_virtual_network_peering.virtual_network_peering_target.name
}

output "vnet_peer_target_id" {
  description = "The id of the newly created virtual network peering in on first virtual netowork. "
  value       = azurerm_virtual_network_peering.virtual_network_peering_target.id
}

output "vnet_peer_source_id" {
  description = "The id of the newly created virtual network peering in on second virtual netowork. "
  value       = azurerm_virtual_network_peering.virtual_network_peering_source.id
}