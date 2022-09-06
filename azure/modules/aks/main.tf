locals {
  extract_resource_name  = "${var.environment}-cp-app-${var.number}-aks"
  extract_node_resource_group_name = "${var.environment}-cp-aks-cluister-rg"
  extract_workspace_name = "${var.environment}-${var.common_name_prefix}-logs"
  extract_solution_name  = "${var.environment}-${var.common_name_prefix}-solution"
}

resource "tls_private_key" "cluster" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_kubernetes_cluster" "main" {
  name                    = local.extract_resource_name
  location                = var.location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.dns_prefix
  private_cluster_enabled = var.private_cluster_enabled
  kubernetes_version      = var.kubernetes_version
  node_resource_group     = local.extract_node_resource_group_name
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    {
      environment = var.environment
    },
    var.tags,
  )

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      key_data = var.public_ssh_key == null ? tls_private_key.cluster.public_key_openssh : file(var.public_ssh_key)
    }
  }

  default_node_pool {
    name                = "nodepool"
    type                = var.node_type
    node_count          = var.initial_node_count
    vm_size             = var.node_size
    os_disk_size_gb     = var.os_disk_size_gb
    vnet_subnet_id      = var.vnet_subnet_id
    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.node_min_count
    max_count           = var.node_max_count
    max_pods            = var.max_pods
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

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count,
      default_node_pool[0].min_count,
      default_node_pool[0].max_count
    ]

  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

    http_application_routing_enabled = var.enable_http_application_routing
    

    oms_agent {
      log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
    }

    // aci_connector_linux {
    //   subnet_name = var.subnet_name
    // }

  dynamic "ingress_application_gateway" {
    # Include this block only if var.ingress_application_gateway_id is
    # set to a non-null value.
    for_each = var.ingress_application_gateway_id[*]
    content {
      gateway_id = var.ingress_application_gateway_id
    }
  }

    // key_vault_secrets_provider {
    //   secret_rotation_enabled = false
    // }

  network_profile {
    network_plugin     = var.network_plugin
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
    service_cidr       = var.service_cidr
    #network_policy     = var.network_policy
    outbound_type = var.outbound_type
    #pod_cidr           = var.pod_cidr  
    load_balancer_sku = var.load_balancer_sku
  }

  dynamic "azure_active_directory_role_based_access_control" {
    # Include this block only if var.ingress_application_gateway_id is
    # set to a non-null value.
    for_each = var.admin_group_object_ids[*]
    content {
      managed                = var.azure_active_directory_enabled
      admin_group_object_ids = var.admin_group_object_ids
    }
  }

}

resource "azurerm_log_analytics_workspace" "main" {
  name                = local.extract_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_retention_in_days
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

resource "azurerm_log_analytics_solution" "main" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  workspace_name        = azurerm_log_analytics_workspace.main.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}