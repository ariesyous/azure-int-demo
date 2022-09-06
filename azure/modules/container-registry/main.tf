locals {
  extract_container_registry_name = join("", [lower(var.common_name_prefix), lower(var.environment), lower(var.name)])
}

resource "azurerm_container_registry" "main" {
  name                = local.extract_container_registry_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  //  georeplication_locations = var.georeplication_locations

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
