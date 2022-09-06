locals {
  extract_resource_name                  = "${var.common_name_prefix}-${var.environment}-${var.name}-apg"
  extract_gateway_ip_configuration_name  = "${var.common_name_prefix}-${var.environment}-${var.name}-apgipcn"
  extract_frontend_ip_configuration_name = "${var.common_name_prefix}-${var.environment}-${var.name}-apfipcn"
  extract_frontend_port_name             = "${var.common_name_prefix}-${var.environment}-${var.name}-apfpn"
}
resource "azurerm_application_gateway" "application_gateway" {
  name                = local.extract_resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = var.sku.capacity
  }

  gateway_ip_configuration {
    name      = local.extract_gateway_ip_configuration_name
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                          = "${local.extract_frontend_ip_configuration_name}-private"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = var.private_ip_address
  }

  frontend_port {
    name = local.extract_frontend_port_name
    port = var.frontend_port
  }

  dynamic "http_listener" {
    for_each = var.services
    iterator = service

    content {
      name                           = "httplistener-${service.value.name}"
      frontend_ip_configuration_name = "${local.extract_frontend_ip_configuration_name}-private"
      frontend_port_name             = local.extract_frontend_port_name
      protocol                       = service.value.http_listener.protocol
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.services
    iterator = service

    content {
      name         = "backendaddresspool-${service.value.name}"
      ip_addresses = service.value.backend_address_pool.ip_addresses
    }
  }

  dynamic "probe" {
    for_each = var.services
    iterator = service

    content {
      name                = "probe-${service.value.name}"
      protocol            = service.value.probe.protocol
      path                = service.value.probe.path
      interval            = service.value.probe.interval
      timeout             = service.value.probe.timeout
      unhealthy_threshold = service.value.probe.unhealthy_threshold
      host                = var.host_name

    }
  }

  dynamic "backend_http_settings" {
    for_each = var.services
    iterator = service

    content {
      name                  = "backendhttpsettings-${service.value.name}"
      protocol              = service.value.backend_http_settings.protocol
      port                  = service.value.backend_http_settings.port
      path                  = service.value.backend_http_settings.path
      cookie_based_affinity = service.value.backend_http_settings.cookie_based_affinity
      request_timeout       = service.value.backend_http_settings.request_timeout
      probe_name            = "probe-${service.value.name}"

    }
  }

  dynamic "request_routing_rule" {
    for_each = var.services
    iterator = service

    content {
      name                       = "requestroutingrule-${service.value.name}"
      http_listener_name         = "httplistener-${service.value.name}"
      backend_address_pool_name  = "backendaddresspool-${service.value.name}"
      backend_http_settings_name = "backendhttpsettings-${service.value.name}"
      rule_type                  = "Basic"
    }
  }

  dynamic "waf_configuration" {
    for_each = var.waf_configuration != null ? [var.waf_configuration] : []

    content {
      enabled                  = var.waf_configuration.enabled
      firewall_mode            = var.waf_configuration.firewall_mode
      rule_set_type            = var.waf_configuration.rule_set_type
      rule_set_version         = var.waf_configuration.rule_set_version
      request_body_check       = var.waf_configuration.request_body_check
      file_upload_limit_mb     = var.waf_configuration.file_upload_limit_mb
      max_request_body_size_kb = var.waf_configuration.max_request_body_size_kb

      dynamic "disabled_rule_group" {
        for_each = var.waf_configuration.disabled_rule_groups
        iterator = disabled_rule_group

        content {
          rule_group_name = disabled_rule_group.value.rule_group_name
          rules           = disabled_rule_group.value.rules
        }
      }
    }
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscale_configuration != null ? [var.autoscale_configuration] : []
    content {
      min_capacity = autoscale_configuration.value.min_capacity
      max_capacity = autoscale_configuration.value.max_capacity
    }
  }
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