resource "null_resource" "main" {
  triggers = {
    ARM_CLIENT_ID              = var.clientID
    ARM_CLIENT_SECRET          = var.clientsecret
    ARM_TENANT_ID              = var.tenantID
    ARM_SUBSCRIPTION_NAME_DEV  = var.subscriptionName_dev
    ARM_SUBSCRIPTION_ID        = var.subscriptionId
    VPN_RESOURCE_GROUP         = var.vpn_resource_group
    VPN_VNET_NAME              = var.vpn_vnet_name
    TARGET_RESOURCE_GROUP_NAME = var.target_resource_group
    TARGET_VNET_NAME           = var.target_vnet_name
    NAME                       = var.name
  }
  provisioner "local-exec" {
    command = <<-EOF

    az login --service-principal --username ${self.triggers.ARM_CLIENT_ID} --password ${self.triggers.ARM_CLIENT_SECRET} --tenant ${self.triggers.ARM_TENANT_ID}
    
    az account set --subscription ${self.triggers.ARM_SUBSCRIPTION_ID}

    targetvNetId=$(az network vnet show \
                 --resource-group ${self.triggers.TARGET_RESOURCE_GROUP_NAME} \
                 --name ${self.triggers.TARGET_VNET_NAME} \
                 --query id \
                 --out tsv)
    
    az account set --subscription ${self.triggers.ARM_SUBSCRIPTION_NAME_DEV}

    echo "Get common VNET subscription ID"
               # Get the id for common Vnet.
               commonvNetId=$(az network vnet show \
                 --resource-group ${self.triggers.VPN_RESOURCE_GROUP} \
                 --name ${self.triggers.VPN_VNET_NAME} \
                 --query id --out tsv)
               
               echo "Creating peering 1" 
               az network vnet peering create \
                     --name vpn-oneapp-peering-${self.triggers.NAME}\
                     --resource-group ${self.triggers.VPN_RESOURCE_GROUP} \
                     --vnet-name ${self.triggers.VPN_VNET_NAME} \
                     --remote-vnet $targetvNetId \
                     --allow-vnet-access
               
               az account set --subscription ${self.triggers.ARM_SUBSCRIPTION_ID}
               
               echo "Creating Peering 2"
               az network vnet peering create \
                     --name oneapp-vpn-peering-${self.triggers.NAME} \
                     --resource-group ${self.triggers.TARGET_RESOURCE_GROUP_NAME}\
                     --vnet-name ${self.triggers.TARGET_VNET_NAME} \
                     --remote-vnet $commonvNetId \
                     --allow-vnet-access
              
              #Get private zone name
               echo "Getting Private Zone Name"
                zone_name=$(az network private-dns zone list -g ${self.triggers.TARGET_RESOURCE_GROUP_NAME} --query '[].name' -o tsv)

               echo "Creating VNET Link"
                  az network private-dns link vnet create --name oneapp-vnetlink-${self.triggers.NAME} --registration-enabled false \
                  --resource-group ${self.triggers.TARGET_RESOURCE_GROUP_NAME} \
                  --virtual-network $commonvNetId \
                  --zone-name $zone_name \
                  --tags CreatedBy=azcli
EOF
  }
  provisioner "local-exec" {
    when    = destroy
    command = <<-EOF
    
        az login --service-principal --username ${self.triggers.ARM_CLIENT_ID} --password ${self.triggers.ARM_CLIENT_SECRET} --tenant ${self.triggers.ARM_TENANT_ID}
    
        az account set --subscription ${self.triggers.ARM_SUBSCRIPTION_ID}
               
        echo "deleting Peering"
          az network vnet peering delete \
            --name oneapp-vpn-peering-${self.triggers.NAME} \
            --resource-group ${self.triggers.TARGET_RESOURCE_GROUP_NAME} \
            --vnet-name ${self.triggers.TARGET_VNET_NAME} 
              
        #Get private zone name
        echo "Getting Private Zone Name"
            zone_name=$(az network private-dns zone list -g ${self.triggers.TARGET_RESOURCE_GROUP_NAME} --query '[].name' -o tsv)

        echo "Deleting VNET Link"
          az network private-dns link vnet delete -g ${self.triggers.TARGET_RESOURCE_GROUP_NAME} -z $zone_name -n oneapp-vnetlink-${self.triggers.NAME} -y                          
    EOF
  }
}
 