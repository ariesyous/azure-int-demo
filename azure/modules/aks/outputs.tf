output "aks_name" {
  value = azurerm_kubernetes_cluster.main.name
}

// output "aks_client_key" {
//   value = azurerm_kubernetes_cluster.main.kube_admin_config.0.client_key
// }

// output "aks_client_certificate" {
//   value = azurerm_kubernetes_cluster.main.kube_admin_config.0.client_certificate
// }

// output "aks_cluster_ca_certificate" {
//   value = azurerm_kubernetes_cluster.main.kube_admin_config.0.cluster_ca_certificate
// }

// output "aks_host" {
//   value = azurerm_kubernetes_cluster.main.kube_admin_config.0.host
// }

// output "aks_username" {
//   value = azurerm_kubernetes_cluster.main.kube_admin_config.0.username
// }

// output "aks_password" {
//   value = azurerm_kubernetes_cluster.main.kube_admin_config.0.password
// }

output "aks_node_resource_group" {
  value = azurerm_kubernetes_cluster.main.node_resource_group
}

output "aks_location" {
  value = azurerm_kubernetes_cluster.main.location
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.main.id
}

output "aks_kube_config_raw" {
  value = azurerm_kubernetes_cluster.main.kube_config_raw
}

output "aks_cluster_ssh_pvt_pem" {
  value = tls_private_key.cluster.private_key_pem
  sensitive = true
}

output "aks_cluster_ssh_pub_pem" {
  value = tls_private_key.cluster.public_key_pem
}

output "aks_cluster_ssh_pub_openssh" {
  value = tls_private_key.cluster.public_key_openssh
}