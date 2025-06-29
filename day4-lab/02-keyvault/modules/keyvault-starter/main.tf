# Key Vault Module - Main Resources
# Build your secure Key Vault infrastructure here!

# TODO: Step 1 - Create Random String for Unique Naming
# Hint: Key Vault names must be globally unique across all of Azure
# resource "random_string" "suffix" {
#   length  = 8
#   special = false
#   upper   = false
# }

# TODO: Step 2 - Get Current Azure AD Configuration
# Hint: We need tenant_id for the Key Vault
# data "azurerm_client_config" "current" {}

# TODO: Step 3 - Create Key Vault with RBAC
# Hint: Use RBAC authorization instead of access policies for better security
# resource "azurerm_key_vault" "main" {
#   name                = "${var.key_vault_name}-${random_string.suffix.result}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   tenant_id           = data.azurerm_client_config.current.tenant_id
#   sku_name            = "standard"
#
#   # Enable RBAC authorization (recommended)
#   enable_rbac_authorization = true
#
#   # Disable legacy access policies since we're using RBAC
#   enabled_for_deployment          = false
#   enabled_for_disk_encryption     = false
#   enabled_for_template_deployment = false
#
#   # Soft delete configuration
#   soft_delete_retention_days = 7
#   purge_protection_enabled   = false
#
#   tags = var.tags
# }

# TODO: Step 4 - Create Managed Identity for Applications
# Hint: This provides secure authentication without storing credentials
# resource "azurerm_user_assigned_identity" "app" {
#   name                = "${var.managed_identity_name}-${random_string.suffix.result}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   tags                = var.tags
# }

# TODO: Step 5 - Assign RBAC Role to Current User (Secrets Officer)
# Hint: This gives you full access to create and manage secrets
# resource "azurerm_role_assignment" "current_user" {
#   scope                = azurerm_key_vault.main.id
#   role_definition_name = "Key Vault Secrets Officer"
#   principal_id         = var.current_user_object_id
# }

# TODO: Step 6 - Assign RBAC Role to Managed Identity (Secrets User)
# Hint: This gives applications read-only access to secrets (least privilege)
# resource "azurerm_role_assignment" "managed_identity" {
#   scope                = azurerm_key_vault.main.id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = azurerm_user_assigned_identity.app.principal_id
# }

# TODO: Step 7 - Create Database Connection String Secret
# Hint: Store the database connection string securely
# resource "azurerm_key_vault_secret" "database_connection_string" {
#   name         = "database-connection-string"
#   value        = "Server=tcp:${var.database_server_name}.database.windows.net,1433;Initial Catalog=${var.database_name};Persist Security Info=False;User ID=${var.database_admin_username};Password=${var.database_admin_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
#   key_vault_id = azurerm_key_vault.main.id
#
#   # Ensure RBAC assignments are created first
#   depends_on = [
#     azurerm_role_assignment.current_user,
#     azurerm_role_assignment.managed_identity
#   ]
# }

# 🎉 When you're done, you should have 6 resources total!
# Test with: terraform validate && terraform plan