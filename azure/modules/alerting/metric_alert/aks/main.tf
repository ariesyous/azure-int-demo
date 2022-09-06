data "azuread_service_principal" "aks_omsprincipal" {
  application_id = var.application_id
}

resource "azurerm_role_assignment" "monpublisher" {
  scope                = var.aks_id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = data.azuread_service_principal.aks_omsprincipal.id
}

#This is added because after role assignment, it takes about 10 mins for the metrics to be published. 
#If the metrics are not published this would fail
#Ref:https://github.com/terraform-providers/terraform-provider-azurerm/issues/6996
resource "null_resource" "waitaks0" {
  provisioner "local-exec" {
    command = "sleep 5"
  }
  depends_on = [azurerm_role_assignment.monpublisher]
}

resource "azurerm_monitor_metric_alert" "nodeCPUmonitor" {
  name                = "Node-CPU-above-threshold-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Action will be triggered when node CPU Usage is greater than 80 for 30 minutes."

  criteria {
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "cpuUsagePercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.node_cpu_threshold

    dimension {
      name     = "Host"
      operator = "Include"
      values   = ["*"]
    }
  }
  frequency   = var.frequency
  window_size = var.window_size
  action {
    action_group_id = var.ag_id
  }
  depends_on = [azurerm_role_assignment.monpublisher]
}

resource "azurerm_monitor_metric_alert" "nodeMemorymonitor" {
  name                = "Node-Memory-above-threshold-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Action will be triggered when node Memory Usage is greater than 80 for 30 minutes."

  criteria {
    metric_namespace = "Insights.Container/nodes"
    metric_name      = "memoryRssPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.node_memory_threshold

    dimension {
      name     = "Host"
      operator = "Include"
      values   = ["*"]
    }
  }
  frequency   = var.frequency
  window_size = var.window_size
  action {
    action_group_id = var.ag_id
  }
  depends_on = [azurerm_role_assignment.monpublisher]
}


resource "azurerm_monitor_metric_alert" "podOOMmonitor" {
  name                = "PodOOM-above-threshold-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Action will be triggered when OOMKilled Container count is greater than 0"

  criteria {
    metric_namespace = "Insights.container/pods"
    metric_name      = "oomKilledContainerCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.pod_oom_count

    dimension {
      name     = "Kubernetes namespace"
      operator = "Include"
      values   = ["*"]
    }
  }
  frequency   = var.frequency
  window_size = var.window_size
  action {
    action_group_id = var.ag_id
  }
  depends_on = [azurerm_role_assignment.monpublisher]
}

resource "azurerm_monitor_metric_alert" "podRestartingmonitor" {
  name                = "Pod-Restarting-above-threshold-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Action will be triggered when Restarting Container count is greater than threshold"

  criteria {
    metric_namespace = "Insights.container/pods"
    metric_name      = "restartingContainerCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.pod_restart_count

    dimension {
      name     = "Kubernetes namespace"
      operator = "Include"
      values   = ["*"]
    }
  }
  frequency   = var.frequency
  window_size = var.window_size
  action {
    action_group_id = var.ag_id
  }
  depends_on = [azurerm_role_assignment.monpublisher]
}

resource "azurerm_monitor_metric_alert" "containerCPUmonitor" {
  name                = "Container-CPU-above-threshold-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Action will be triggered when container CPU Usage is greater than 80 for 30 minutes."

  criteria {
    metric_namespace = "Insights.container/containers"
    metric_name      = "cpuExceededPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.container_cpu_threshold

    dimension {
      name     = "containerName"
      operator = "Include"
      values   = ["*"]
    }
  }
  frequency   = var.frequency
  window_size = var.window_size
  action {
    action_group_id = var.ag_id
  }
  depends_on = [azurerm_role_assignment.monpublisher]
}

resource "azurerm_monitor_metric_alert" "containerMemorymonitor" {
  name                = "Container-Memory-above-threshold-alert--${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.aks_id]
  description         = "Action will be triggered when container CPU Usage is greater than threshold"

  criteria {
    metric_namespace = "Insights.container/containers"
    metric_name      = "memoryRssExceededPercentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.container_memory_threshold

    dimension {
      name     = "containerName"
      operator = "Include"
      values   = ["*"]
    }
  }
  frequency   = var.frequency
  window_size = var.window_size
  action {
    action_group_id = var.ag_id
  }
  depends_on = [azurerm_role_assignment.monpublisher]
}