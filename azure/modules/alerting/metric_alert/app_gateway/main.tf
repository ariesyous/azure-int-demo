resource "azurerm_monitor_metric_alert" "appGateway4xx" {
  name                = "Gateway-4xx-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.one_ag_id]
  description         = "Action will be triggered when the number of 4xx errors passes the required threshold in given time space"

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ResponseStatus"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.threshold_4xx

    dimension {
      name     = "HttpStatusGroup"
      operator = "Include"
      values   = ["4xx"]
    }
  }
  frequency   = var.frequency
  window_size = var.window_size
  action {
    action_group_id = var.ag_id
  }
}



resource "azurerm_monitor_metric_alert" "appGateway5xx" {
  name                = "Gateway-5xx-alert-${var.environment}"
  resource_group_name = var.resource_group_name
  scopes              = [var.one_ag_id]
  description         = "Action will be triggered when the number of 5xx errors passes the required threshold in given time space"

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ResponseStatus"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = var.threshold_5xx

    dimension {
      name     = "HttpStatusGroup"
      operator = "Include"
      values   = ["5xx"]
    }
  }
  frequency   = var.frequency
  window_size = var.window_size
  action {
    action_group_id = var.ag_id
  }
}