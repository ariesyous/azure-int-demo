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
  description = "Name of the resources"
  type        = string
}

variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

#private frontend ip
variable "private_ip_address_allocation" {
  type    = string
  default = "Static"
}
variable "private_ip_address" {
  type    = string
  default = ""
}
#Application Gateway Variables
variable "sku" {
  type = object({
    name     = string
    tier     = string
    capacity = number
  })
}


variable "host_name" {
  type = string
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "frontend_port" {
  type = number
}

variable "services" {
  type = list(object({
    name = string

    http_listener = object({
      protocol = string
    })

    backend_address_pool = object({
      ip_addresses = list(string)
    })

    probe = object({
      protocol            = string
      path                = string
      interval            = number
      timeout             = number
      unhealthy_threshold = number
    })

    backend_http_settings = object({
      protocol              = string
      port                  = number
      path                  = string
      cookie_based_affinity = string
      request_timeout       = number
    })
  }))
}

variable "waf_configuration" {
  type = object({
    enabled          = bool
    firewall_mode    = string
    rule_set_type    = string
    rule_set_version = string
    disabled_rule_groups = list(object({
      rule_group_name = string
      rules           = list(string)
    }))
    request_body_check       = bool
    file_upload_limit_mb     = number
    max_request_body_size_kb = number
  })
  default = null
}

variable "autoscale_configuration" {
  type = object({
    min_capacity = number # in the range 0 to 100.
    max_capacity = number # in the range 2 to 125.
  })
  default = null
}

variable "tags" {
  type = map
}