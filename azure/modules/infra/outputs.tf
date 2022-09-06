#Resource Group Outputs

output "id" {
  value = module.resource_group.id
}
output "name" {
  value = module.resource_group.name
}
#VNET Outputs

output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = module.vnet.vnet_name
}

output "vnet_location" {
  description = "The location of the newly created vNet"
  value       = module.vnet.vnet_location
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = module.vnet.vnet_address_space
}

output "resource_group_name" {
  description = "The address space of the newly created vNet"
  value       = module.vnet.resource_group_name
}

#Subnet Variables
// output "subnet_name" {
//   description = "The name of the subnet created"
//   value       = tolist(module.subnet[*].subnet_name)
// }

output "subnet_name" {
  value = {for k, v in module.subnet: k => v.subnet_name}
}

// output "subnet_id" {
//   description = "The id of the subnet created"
//   value       = module.subnet.subnet_id
// }

output "subnet_id" {
  value = {for k, v in module.subnet: k => v.subnet_id}
}

// output "address_prefixes" {
//   description = "value of subnet prefix"
//   value       = module.subnet.address_prefixes
// }

output "address_prefixes" {
  value = {for k, v in module.subnet: k => v.address_prefixes}
}

#SQL Server Outputs
output "postgres_server_id" {
  value = module.postgres_sql_server.postgres_server_id
}

output "postgres_server_fqdn" {
  value = module.postgres_sql_server.postgres_server_fqdn
}

output "postgres_server_private_endpoint" {
  value = module.private_endpoint.private_service_connection
}

output "postgres_password" {
  value = module.postgres_sql_server.postgres_password
  sensitive = true
}


#Cluster SSH Ket Outputs
output "aks_cluster_ssh_pvt_pem" {
  value = module.aks.aks_cluster_ssh_pvt_pem
  sensitive = true
}

output "aks_cluster_ssh_pub_pem" {
  value = module.aks.aks_cluster_ssh_pub_pem
}

output "aks_cluster_ssh_pub_openssh" {
  value = module.aks.aks_cluster_ssh_pub_openssh
}

output "aks_name" {
  value = module.aks.aks_name
}


#Redis


output "redis_hostname" {
  value = module.redis.redis_hostname
}

output "redis_port" {
  value = module.redis.redis_port
}



#Public IP
output "public_ip_address" {
  description = "The public IP address allocated."
  value       = join("", module.public_ip.*.public_ip_address)
}

#Storage Container
output "storage_container_name" {
  description = "The public IP address allocated."
  value       = module.storage_container.name
}

#LetEncrypt Cert Output
output "private_key_pem" {
    value = join("", module.letsencrypt_cert.*.private_key_pem)
    sensitive = true
}

output "certificate_pem" {
    value = module.letsencrypt_cert.*.certificate_pem
}

output "certificate_p12" {
    value = join("", module.letsencrypt_cert.*.certificate_p12)
    sensitive = true
}

output "certificate_url" {
    value = join("", module.letsencrypt_cert.*.certificate_url )
}

output "certificate_domain" {
    value = join("", module.letsencrypt_cert.*.certificate_domain)
}

output "certificate_id" {
    value = join("", module.letsencrypt_cert.*.certificate_id)
}

#DNS Zone
output "zone_id" {
  value = join("",module.dns_zone.*.zone_id)
}

output "zone_name" {
  value = join("",module.dns_zone.*.zone_name)
}

output "zone_ns_records" {
  value = join("",module.dns_zone.*.zone_ns_records)
}

#Key Vault
output "key_vault_name" {
  value = module.key_vault.resource_name
}

#Keys
output "key_name" {
  value = module.keys.key_name
}

