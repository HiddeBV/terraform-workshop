output "app_service_name" {
  description = "Name of the App Service"
  value       = module.app_service.app_service_name
}

output "app_service_id" {
  description = "ID of the App Service"
  value       = module.app_service.app_service_id
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = module.app_service.app_service_url
}

output "app_service_hostname" {
  description = "Default hostname of the App Service"
  value       = module.app_service.app_service_default_hostname
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = module.app_service.app_service_plan_name
}

output "app_service_plan_id" {
  description = "ID of the App Service Plan"
  value       = module.app_service.app_service_plan_id
}

output "resource_group_name" {
  description = "Name of the resource group containing App Service resources"
  value       = module.app_service.resource_group_name
}