variable "resource_group" {
  description = "Resource Group to create the DNS zone in"
  type        = string
}

variable "internal_domain_name" {
  description = "Private Domain Name"
  type        = string
}