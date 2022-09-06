locals {
  extract_name = join("", [lower(var.environment),"cp",substr(lower(var.common_name_prefix),0,4),"001",lower("st")])
  storage_name = substr(local.extract_name, 0, 19)
}

resource "azurerm_storage_account" "main" {
  name                      = substr(lower("${local.storage_name}${var.random_id}"),0, 23)
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replica
  access_tier               = var.access_tier
  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    {
      environment = var.environment
    },
    var.tags,
  )

  identity {
    type = var.assign_identity ? "SystemAssigned" : null
  }

  blob_properties {
    delete_retention_policy {
      days = var.soft_delete_retention
    }
  }
  dynamic network_rules {
    for_each = var.network_rules != null ? [var.network_rules] : []
    content {
      default_action             = network_rules.value.default_action
      bypass                     = network_rules.value.network_rules.bypass
      ip_rules                   = network_rules.value.network_rules.ip_rules
      virtual_network_subnet_ids = network_rules.value.network_rules.subnet_ids
    }
  }
}
resource "azurerm_advanced_threat_protection" "atp" {
  target_resource_id = azurerm_storage_account.main.id
  enabled            = var.enable_blob_public_access
}