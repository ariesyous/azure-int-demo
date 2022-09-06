variable "resource_group_name" {
  description = "Specifies the Resource Group where resource needs to be created."
  type        = string
}

variable "domain_name" {
  description = "The certificate's common name, the primary domain that the certificate will be recognized for. Required when not specifying a CSR. Forces a new resource when changed."
  type        = string
}

variable "email" {
  description = "Specifies the Resource Group where resource needs to be created."
  type        = string
  default     = "vanguard@cldcvr.com"
}

variable "subscription_id" {
  description = "Specifies the Subscription where resource needs to be created."
  type        = string
}

variable "client_id" {
  description = "Specifies the Client where resource needs to be created."
  type        = string
}
