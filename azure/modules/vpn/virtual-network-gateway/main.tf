locals {
  extract_resource_name = "001-${var.environment}-${var.common_name_prefix}-gw-v-vnet"
}
resource "random_string" "str" {
  length  = 6
  special = false
  upper   = false
  keepers = {
    domain_name_label = local.extract_resource_name
  }
}

#-------------------------------
# Subnet
#-------------------------------
resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.45.0/24"]
}
#-------------------------------
# Virtual Network Gateway 
#-------------------------------
resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = local.extract_resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  type                = var.gateway_type
  vpn_type            = var.gateway_type != "ExpressRoute" ? var.vpn_type : null
  sku                 = var.gateway_type != "ExpressRoute" ? var.vpn_gw_sku : var.expressroute_sku
  active_active       = var.vpn_gw_sku != "Basic" ? var.enable_active_active : false
  enable_bgp          = var.vpn_gw_sku != "Basic" ? var.enable_bgp : false
  generation          = var.vpn_gw_generation


  dynamic "bgp_settings" {
    for_each = var.enable_bgp ? [true] : []
    content {
      asn             = var.bgp_asn_number
      #peering_address = var.bgp_peering_address
      peer_weight     = var.bgp_peer_weight
    }
  }

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = var.public_ip_address_id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet.id
  }

  dynamic "ip_configuration" {
    for_each = var.enable_active_active ? [true] : []
    content {
      name                          = "vnetGatewayAAConfig"
      public_ip_address_id          = var.public_ip_address_id
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = azurerm_subnet.gateway_subnet.id
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = var.vpn_client_configuration != null ? [var.vpn_client_configuration] : []
    iterator = vpn
    content {
      address_space = [vpn.value.address_space]
      root_certificate {
        name             = "point-to-site-root-certifciate"
        public_cert_data = vpn.value.certificate
      }
      vpn_client_protocols = vpn.value.vpn_client_protocols
    }
  }

  depends_on = [
    azurerm_subnet.gateway_subnet
  ]

  tags = merge({ "ResourceName" = "${var.vpn_gateway_name}" }, var.tags, )
}
