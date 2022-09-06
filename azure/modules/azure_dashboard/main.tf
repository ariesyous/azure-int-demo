locals {
  extract_dashboard_name                  = "${var.common_name_prefix}-${var.environment}-${var.name}"
}

resource "azurerm_dashboard" "my-board" {
  name                = local.extract_dashboard_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags = merge(
   {
     "Name" = format("%s", var.name)
   },
   {
     environment = var.environment
   },
   var.tags,
  )
 
  dashboard_properties = templatefile(var.template_file,
  {
      aks_id = var.aks_resource_id
      ingress_id = var.ingress_resource_id
      cregistry_id = var.cregistry_resource_id
  })

}