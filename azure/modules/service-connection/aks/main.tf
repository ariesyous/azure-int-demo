locals {
  service_endpoint_name = "${var.common_name_prefix}-${var.name}-${var.environment}-sp-conn-terraform"
}
data "azuredevops_project" "main" {
  name = var.project_name
}

resource "azuredevops_serviceendpoint_kubernetes" "main" {
  project_id            = data.azuredevops_project.main.id
  service_endpoint_name = local.service_endpoint_name
  apiserver_url         = var.apiserver_url
  authorization_type    = var.authorization_type
  azure_subscription {
    subscription_id   = var.subscription_id
    subscription_name = var.subscription_name
    tenant_id         = var.tenant_id
    resourcegroup_id  = var.resourcegroup_id
    namespace         = var.namespace
    cluster_name      = var.cluster_name
  }
}