resource "null_resource" "cluster" {

  provisioner "local-exec" {
    command = <<-EOF

    az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID

    az network dns zone create -g $resource_group -n $zone_name --subscription $subscription_id --parent-name "/subscriptions/b291304b-c8b6-449f-8b73-43e4ae3c2c24/resourceGroups/one-common-rg/providers/Microsoft.Network/dnszones/tech.onefc.com"
EOF
    environment = {
      ARM_CLIENT_ID     = var.clientID
      ARM_CLIENT_SECRET = var.clientsecret
      ARM_TENANT_ID     = var.tenantID
      resource_group    = var.resource_group
      zone_name         = var.zone_name
      subscription_id   = var.subscriptionId
    }
  }
}

variable "clientID" {}
variable "clientsecret" {}
variable "tenantID" {}
variable "resource_group" {}
variable "zone_name" {}
variable "subscriptionId" {}