variable "host" {}
variable "client_certificate" {}
variable "client_key" {}
variable "cluster_ca_certificate" {}
variable "password" {}
variable "username" {}

variable "metadata" {
  type    = list
  default = []
}
