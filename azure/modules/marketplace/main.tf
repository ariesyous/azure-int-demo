# Accept the agreement.

data "azurerm_subscription" "current" {
}

resource "azurerm_marketplace_agreement" "openvpn" {
  publisher = var.publisher
  offer     = var.offer
  plan      = var.plan
}