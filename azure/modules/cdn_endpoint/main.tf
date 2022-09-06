
resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  count                         = var.enabled_cdn == true ? 1 : 0
  origin_host_header            = var.origin_host_name
  name                          = var.name
  profile_name                  = var.cdn_profile_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  is_http_allowed               = var.is_http_allowed
  is_https_allowed              = var.is_https_allowed
  querystring_caching_behaviour = var.querystring_caching_behaviour
  optimization_type             = var.optimization_type
  origin_path                   = var.origin_path

  origin {
    name       = var.name
    host_name  = var.origin_host_name
    http_port  = var.origin_http_port
    https_port = var.origin_https_port

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