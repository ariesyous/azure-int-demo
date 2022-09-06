variable "storage_container_name" {
  description = "The storage container name"
  type        = string
}

variable "storage_container_access_type" {
  description = "The container access type"
  default     = "private"
}

variable "storage_account_name" {
  description = "storage account name"
  type = string
}
