output "name" {
  value = azurerm_marketplace_agreement.openvpn.plan
}

output "offer" {
  value = azurerm_marketplace_agreement.openvpn.offer
}

output "plan" {
  value = azurerm_marketplace_agreement.openvpn.plan
}

output "publisher" {
  value = azurerm_marketplace_agreement.openvpn.publisher
}

output "id" {
  value = azurerm_marketplace_agreement.openvpn.id
}

output "current_subscription_display_name" {
  value = data.azurerm_subscription.current.display_name
}