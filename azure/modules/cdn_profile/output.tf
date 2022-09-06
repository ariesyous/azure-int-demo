output "name" {
  value = join("", azurerm_cdn_profile.cdn_profile[*].name)
}