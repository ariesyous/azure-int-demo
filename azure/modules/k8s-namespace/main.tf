provider "kubernetes" {
  version                = "~> 1.13.3"
  host                   = var.host
  client_certificate     = var.client_certificate
  client_key             = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
  load_config_file       = false
  username               = var.username
  password               = var.password
}

resource "kubernetes_namespace" "main" {
  count = length(var.metadata)
  metadata {
    labels = var.metadata[count.index]["labels"]
    name   = var.metadata[count.index]["name"]
  }
}
