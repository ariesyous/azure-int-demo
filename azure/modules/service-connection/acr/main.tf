locals {
  service_endpoint_name = "${var.common_name_prefix}-${var.name}-${var.environment}-sp-conn-terraform"
}
data "azuredevops_project" "main" {
  name = var.project_name
}


resource "azuredevops_serviceendpoint_azurecr" "main" {
  project_id                = data.azuredevops_project.main.id
  service_endpoint_name     = local.service_endpoint_name
  resource_group            = var.resourcegroup_id
  azurecr_spn_tenantid      = var.tenant_id
  azurecr_name              = var.acr_name
  azurecr_subscription_id   = var.subscription_id
  azurecr_subscription_name = var.subscription_name
}
