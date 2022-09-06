variable "resource_group" {
  description = "Resource Group to create the DNS zone in"
  type        = string
}

variable "external_domain_name" {
  description = "Public Domain Name"
  type        = string
}
