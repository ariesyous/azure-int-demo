locals {
  service_endpoint_name = "${var.common_name_prefix}-${var.name}-${var.environment}-svc-conn-terraform"
}
data "azuredevops_project" "main" {
  name = var.project_name
}

resource "azuredevops_serviceendpoint_azurerm" "main" {
  project_id                = data.azuredevops_project.main.id
  service_endpoint_name     = local.service_endpoint_name
  azurerm_spn_tenantid      = var.azurerm_spn_tenantid
  azurerm_subscription_id   = var.azurerm_subscription_id
  azurerm_subscription_name = var.azurerm_subscription_name
  credentials {
    serviceprincipalid  = var.serviceprincipalid
    serviceprincipalkey = var.serviceprincipalkey
  }
}