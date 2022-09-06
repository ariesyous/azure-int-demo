variable "name" {
  description = "name of the rg group"
  type        = string
}
variable "location" {
  description = "The data center location where all resources will be put into."
  type        = string
}

variable "environment" {
  description = "The name type of environment to deploy resoursces"
  type        = string
}

variable "common_name_prefix" {
  description = "The prefix used to name all resources created."
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "Any tags that should be present on the Virtual Network resources"
  default     = {}
}

