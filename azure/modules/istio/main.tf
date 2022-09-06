###################Install Istio (Service Mesh) #######################################
// resource "random_password" "password" {
//   length           = 16
//   special          = true
//   override_special = "_%@"
// }

// data "azurerm_subscription" "current" {
// }



// resource "local_file" "kube_config" {
//   content    = var.aks_kubeconfig
//   filename   = ".kube/${var.aks_cluster_name}"   
// }

// resource "null_resource" "set-kube-config" {
//   triggers = {
//     always_run = "${timestamp()}"
//   }

//   provisioner "local-exec" {
//     command = "az aks get-credentials -n ${var.aks_cluster_name} -g ${var.resource_group_name} --file \".kube/${var.aks_cluster_name}\" --admin --overwrite-existing"
//   }
//   depends_on = [local_file.kube_config]
// }

resource "null_resource" "install-itioctl" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = <<-EOT
        curl -L https://istio.io/downloadIstio | ISTIO_VERSION=${var.istio_version} sh -
    EOT
  }
}


resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }
}

resource "helm_release" "istio_base" {
  name  = "istio-base"
  chart = "istio-${var.istio_version}/manifests/charts/base"

  timeout = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = "istio-system"


  depends_on = [null_resource.install-itioctl, kubernetes_namespace.istio_system]
}

resource "helm_release" "istiod" {
  name  = "istiod"
  chart = "istio-${var.istio_version}/manifests/charts/istio-control/istio-discovery"

  timeout = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = "istio-system"

  depends_on = [null_resource.install-itioctl, kubernetes_namespace.istio_system, helm_release.istio_base]
}

resource "helm_release" "istio_ingress" {
  name  = "istio-ingress"
  chart = "istio-${var.istio_version}/manifests/charts/gateways/istio-ingress"

  timeout = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = "istio-system"

  depends_on = [null_resource.install-itioctl, kubernetes_namespace.istio_system, helm_release.istiod]
}

resource "helm_release" "istio_egress" {
  name  = "istio-egress"
  chart = "istio-${var.istio_version}/manifests/charts/gateways/istio-egress"

  timeout = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = "istio-system"

  depends_on = [null_resource.install-itioctl, kubernetes_namespace.istio_system, helm_release.istio_ingress]
}


// resource "kubernetes_secret" "grafana" {
//   metadata {
//     name      = "grafana"
//     namespace = "istio-system"
//     labels = {
//       app = "grafana"
//     }
//   }
//   data = {
//     username   = "admin"
//     passphrase = random_password.password.result
//   }
//   type       = "Opaque"
//   depends_on = [kubernetes_namespace.istio_system]
// }

// resource "kubernetes_secret" "kiali" {
//   metadata {
//     name      = "kiali"
//     namespace = "istio-system"
//     labels = {
//       app = "kiali"
//     }
//   }
//   data = {
//     username   = "admin"
//     passphrase = random_password.password.result
//   }
//   type       = "Opaque"
//   depends_on = [kubernetes_namespace.istio_system]
// }

// resource "local_file" "istio-config" {
//   content = templatefile("${path.module}/istio-aks.tmpl", {
//     enableGrafana = true
//     enableKiali   = true
//     enableTracing = true
//   })
//   filename = ".istio/istio-aks.yaml"
// }

// resource "null_resource" "istio" {
//   triggers = {
//     always_run = "${timestamp()}"
//   }
//   provisioner "local-exec" {
//     command = "istioctl manifest apply -f \".istio/istio-aks.yaml\" --kubeconfig \".kube/${var.aks_cluster_name}\""
//   }
//   depends_on = [kubernetes_secret.grafana, kubernetes_secret.kiali, local_file.istio-config]
// }