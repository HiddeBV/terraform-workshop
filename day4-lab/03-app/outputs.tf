output "app_service_name" {
  description = "Name of the App Service"
  value       = azurerm_linux_web_app.main.name
}

output "app_service_id" {
  description = "ID of the App Service"
  value       = azurerm_linux_web_app.main.id
}

output "app_service_url" {
  description = "URL of the App Service"
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "app_service_hostname" {
  description = "Default hostname of the App Service"
  value       = azurerm_linux_web_app.main.default_hostname
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.main.name
}

output "app_service_plan_id" {
  description = "ID of the App Service Plan"
  value       = azurerm_service_plan.main.id
}

output "resource_group_name" {
  description = "Name of the resource group containing App Service resources"
  value       = azurerm_resource_group.app.name
}

output "app_service_identity" {
  description = "Managed identity configuration of the App Service"
  value = {
    type         = azurerm_linux_web_app.main.identity[0].type
    principal_id = azurerm_linux_web_app.main.identity[0].principal_id
    tenant_id    = azurerm_linux_web_app.main.identity[0].tenant_id
    identity_ids = azurerm_linux_web_app.main.identity[0].identity_ids
  }
}