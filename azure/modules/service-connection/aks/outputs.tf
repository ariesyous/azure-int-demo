output "id" {
  value = data.azuredevops_project.main.id
}

output "project_name" {
  value = data.azuredevops_project.main.name
}

output "visibility" {
  value = data.azuredevops_project.main.visibility
}

output "version_control" {
  value = data.azuredevops_project.main.version_control
}

output "work_item_template" {
  value = data.azuredevops_project.main.work_item_template
}

output "process_template_id" {
  value = data.azuredevops_project.main.process_template_id
}

output "service_endpoint_id" {
  value = azuredevops_serviceendpoint_kubernetes.main.id
}
output "project_id" {
  value = azuredevops_serviceendpoint_kubernetes.main.project_id
}

output "service_endpoint_name" {
  value = azuredevops_serviceendpoint_kubernetes.main.service_endpoint_name
}