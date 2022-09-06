locals {
  extract_resource_name  = "${var.common_name_prefix}-${var.environment}-${var.name}-aks"
  extract_workspace_name = "${var.common_name_prefix}-${var.environment}-${var.name}-workspace"
  extract_solution_name  = "${var.common_name_prefix}-${var.environment}-${var.name}-solution-name"
}

resource "azurerm_kubernetes_cluster_node_pool" "aks" {
  lifecycle {
    ignore_changes = [
      node_count
    ]
  }
  for_each              = var.additional_node_pools
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  name                  = each.value.name
  node_count            = each.value.node_count
  vm_size               = each.value.vm_size
  max_pods              = each.value.max_pods
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_type               = each.value.node_os
  vnet_subnet_id        = var.vnet_subnet_id
  enable_auto_scaling   = each.value.enable_auto_scaling
  min_count             = each.value.cluster_auto_scaling_min_count
  max_count             = each.value.cluster_auto_scaling_max_count
}
