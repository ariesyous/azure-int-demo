output "zone_id" {
  value = azurerm_dns_zone.zone_public.id
}

output "zone_name" {
  value = azurerm_dns_zone.zone_public.name
}

output "zone_ns_records" {
  value = azurerm_dns_zone.zone_public.name_servers
}
