output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = azurerm_key_vault.main.id
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.main.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.main.vault_uri
}

output "resource_group_name" {
  description = "Name of the resource group containing Key Vault resources"
  value       = azurerm_resource_group.keyvault.name
}

output "managed_identity_id" {
  description = "ID of the managed identity"
  value       = azurerm_user_assigned_identity.app.id
}

output "managed_identity_client_id" {
  description = "Client ID of the managed identity"
  value       = azurerm_user_assigned_identity.app.client_id
}

output "managed_identity_principal_id" {
  description = "Principal ID of the managed identity"
  value       = azurerm_user_assigned_identity.app.principal_id
}

output "database_connection_string_secret_name" {
  description = "Name of the database connection string secret in Key Vault"
  value       = azurerm_key_vault_secret.db_connection_string.name
}

output "app_config_secret_name" {
  description = "Name of the app configuration secret in Key Vault"
  value       = azurerm_key_vault_secret.app_config.name
}