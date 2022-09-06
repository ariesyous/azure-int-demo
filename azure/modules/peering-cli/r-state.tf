# data "terraform_remote_state" "vnet" {
#   backend = "azurerm"
#   config = {
#         storage_account_name = var.storage_account_name
#         container_name = var.container_name
#         TARGET_RESOURCE_GROUP_NAME = var.TARGET_RESOURCE_GROUP_NAME
#         key = "dev/common/vpn-config/vpn-vnet/terraform.tfstate"
#         subscription_id = var.subscriptionId
#         tenant_id = var.tenantID
#         client_id = var.clientID
#         client_secret = var.clientsecret
#     }
# }
# output "vnet_id"{
#   value= data.terraform_remote_state.vnet.outputs.vnet_id
# }
# output "vnet_name"{
#   value= data.terraform_remote_state.vnet.outputs.vnet_name
# }
# output "TARGET_RESOURCE_GROUP_NAME"{
#   value= data.terraform_remote_state.vnet.outputs.TARGET_RESOURCE_GROUP_NAME
# }
# variable "storage_account_name" {}
# variable "container_name" {} 
# variable "TARGET_RESOURCE_GROUP_NAME" {}
# variable "tenantID" {}
# variable "clientID" {}
# variable "clientsecret" {}
# variable "subscriptionId" {}