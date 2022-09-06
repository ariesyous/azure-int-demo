locals {
  nic_name       = "${var.common_name_prefix}-${var.environment}-${var.name}-nic"
  ip_config_name = "${var.common_name_prefix}-${var.environment}-${var.name}-nicipcn"
  resource_name  = "${var.common_name_prefix}-${var.environment}-${var.name}-vm"
}

resource "azurerm_network_interface" "network_interface" {
  name                = local.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = local.ip_config_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = var.static_public_ip
  }
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  name                  = local.resource_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.network_interface.id]
  admin_username        = var.admin_username
  size                  = var.size

  dynamic "source_image_reference" {
    for_each = var.source_image_reference
    content {
      publisher = source_image_reference.value["publisher"]
      offer     = source_image_reference.value["offer"]
      sku       = source_image_reference.value["sku"]
      version   = source_image_reference.value["version"]
    }
  }

  os_disk {
    name                      = var.os_disk.name
    caching                   = var.os_disk.caching
    storage_account_type      = var.os_disk.storage_account_type
    disk_encryption_set_id    = var.os_disk.disk_encryption_set_id
    disk_size_gb              = var.os_disk.disk_size_gb
    write_accelerator_enabled = var.os_disk.write_accelerator_enabled
  }

  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_key
    content {
      username   = admin_ssh_key.value["username"]
      public_key = admin_ssh_key.value["public_key"]
    }
  }

  dynamic "plan" {
    for_each = var.plans
    content {
      name      = plan.value["name"]
      product   = plan.value["product"]
      publisher = plan.value["publisher"]
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

