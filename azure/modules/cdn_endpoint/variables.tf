# General variables 
variable "environment" {
  description = "The name for identifying the type of environment"
  type        = string
}

variable "location" {
  description = "The data center location where all resources will be put into."
  type        = string
}

variable "common_name_prefix" {
  description = "The prefix used to name all resources created."
  type        = string
}

variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

# public ip variables 

variable "cdn_profile_name" {
  description = "The CDN profile name."
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the CDN resources"
  default     = {}
}

variable "origin_host_name" {
  type        = string
  description = "Any tags that should be present on the CDN resources"
}

variable "is_http_allowed" {
  description = "Allow HTTP. "
  default     = false
}

variable "is_https_allowed" {
  description = "Allow HTTPS. "
  default     = true
}

variable "querystring_caching_behaviour" {
  description = "Sets query string caching behavior. "
  default     = "IgnoreQueryString"
}

variable "optimization_type" {
  description = "What types of optimization should this CDN Endpoint optimize for? "
  default     = "GeneralWebDelivery"
}

variable "origin_http_port" {
  description = "The HTTP port of the origin. "
  default     = 80
}

variable "origin_https_port" {
  description = "The HTTPS port of the origin. "
  default     = 443
}

variable "enabled_cdn" {
  description = "Check whether CDN is enabled or not"
  type        = bool
}

variable "origin_path" {
  description = "The path used at for origin requests."
  default     = ""
}

# variable "delivery_rule_request_scheme_condition" {
#   type = list(object({
#     name         = string
#     order        = number
#     operator     = string
#     match_values = list(string)
#     url_redirect_action = object({
#       redirect_type = string
#       protocol      = string
#       hostname      = string
#       path          = string
#       fragment      = string
#       query_string  = string
#     })
#   }))
#   default = []
# }