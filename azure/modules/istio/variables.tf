# General variables 
variable "resource_group_name" {
  description = " Specifies the Resource Group where resource needs to be created."
  type        = string
}

#Istio Variables
variable "aks_kubeconfig" {
  description = " Specifies the AKS Kubeconfig for Istio to be installed."
  type        = string
}

variable "aks_cluster_name" {
  description = " Specifies the AKS Cluster Name for Istio to be installed."
  type        = string
}
variable "aks_host" {
  description = " Specifies the AKS Host."
  type        = string
}
variable "aks_token" {
  description = " Specifies the AKS Token."
  type        = string
}
variable "aks_ca_certificate" {
  description = " Specifies the AKS Cluster CA Certificate."
  type        = string
}
variable "aks_client_certificate" {
  description = " Specifies the AKS Cluster Client Certificate."
  type        = string
}

variable "istio_version" {
  description = "Istio Version to be installed."
  type        = string
  default     = "1.11.4"
}
