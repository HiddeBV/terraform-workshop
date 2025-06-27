output "storage_account_name" {
  description = "Name of the storage account for Terraform state"
  value       = azurerm_storage_account.backend.name
}

output "container_name" {
  description = "Name of the container for Terraform state"
  value       = azurerm_storage_container.tfstate.name
}

output "resource_group_name" {
  description = "Name of the resource group containing backend resources"
  value       = azurerm_resource_group.backend.name
}

output "storage_account_primary_access_key" {
  description = "Primary access key for the storage account"
  value       = azurerm_storage_account.backend.primary_access_key
  sensitive   = true
}

output "backend_config" {
  description = "Backend configuration for use in other modules"
  value = {
    resource_group_name  = azurerm_resource_group.backend.name
    storage_account_name = azurerm_storage_account.backend.name
    container_name       = azurerm_storage_container.tfstate.name
  }
}