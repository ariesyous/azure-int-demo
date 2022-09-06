locals {
  Name = "${var.common_name_prefix}-${var.connName}-${var.environment}-sp-conn-terraform"
}


data "template_file" "main" {
  template = file("./template.json")
  vars = {
    subscriptionId   = var.subscriptionId
    subscriptionNAME = var.subscriptionNAME
    clusterID        = var.clusterID
    tenantID         = var.tenantID
    connName         = local.Name
    aksHost          = var.aksHost
  }
}

resource "local_file" "main" {
  content  = data.template_file.main.rendered
  filename = "./k8s-conn.json"
}

resource "null_resource" "main" {
  provisioner "local-exec" {
    command = <<-EOF
    curl -H 'Content-Type: application/json' -X POST -d @k8s-conn.json -u $USERNAME:$PAT https://dev.azure.com/ONE-Engineering/ONE%20Super%20App/_apis/serviceendpoint/endpoints?api-version=5.0-preview.2
  
  EOF

    environment = {
      USERNAME = var.username
      PAT      = var.PAT
    }
  }
  depends_on = [local_file.main]
}
# provisioner "local-exec" {
#   when= destroy
#   command = "curl -H 'Content-Type: application/json' -X POST -d @k8s-conn.json -u ${var.username}:${var.PAT} https://dev.azure.com/ONE-Engineering/ONE%20Super%20App/_apis/serviceendpoint/endpoints?api-version=5.0-preview.2"
# }

