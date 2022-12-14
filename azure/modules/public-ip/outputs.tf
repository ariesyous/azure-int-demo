output "public_ip_address" {
  description = "The public IP address allocated."
  value       = azurerm_public_ip.public_ip.ip_address
}

output "public_ip_id" {
  description = "The id of the public IP address allocated."
  value       = azurerm_public_ip.public_ip.id
}