output "aks_rg_id" {
  value = module.infra.id
}
output "aks_rg" {
  value = module.infra.name
}

output "db_instance_address" {
  value = module.infra.postgres_server_private_endpoint
}

output "redis_hostname" {
  value = module.infra.redis_hostname
}

output "aks_name" {
  value = module.infra.aks_name
}

output "postgres_password" {
  value = module.infra.postgres_password
  sensitive= true
}

output "postgres_user" {
  value = "${var.postgres_administrator_login}@${module.infra.postgres_server_fqdn}"
}