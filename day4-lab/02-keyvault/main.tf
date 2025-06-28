terraform {
  required_version = ">= 1.12.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
  
  # Backend configuration - update with your backend details from Sprint 1
  backend "azurerm" {
    # resource_group_name  = "rg-terraform-backend-xxxxxxxx"  # From Sprint 1 output
    # storage_account_name = "stterraformxxxxxxxx"            # From Sprint 1 output
    # container_name       = "tfstate"                        # From Sprint 1 output
    # key                  = "keyvault.tfstate"
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

# Get current client configuration
data "azurerm_client_config" "current" {}

# Data source to get network resource group info
data "azurerm_resource_group" "network" {
  name = var.network_resource_group_name
}

# Generate a random suffix for unique naming
resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

# Resource Group for Key Vault
resource "azurerm_resource_group" "keyvault" {
  name     = "${var.resource_group_name}-${random_string.suffix.result}"
  location = var.location

  tags = var.tags
}

# User-assigned managed identity for applications
resource "azurerm_user_assigned_identity" "app" {
  name                = "${var.managed_identity_name}-${random_string.suffix.result}"
  location            = azurerm_resource_group.keyvault.location
  resource_group_name = azurerm_resource_group.keyvault.name

  tags = var.tags
}

# Key Vault
resource "azurerm_key_vault" "main" {
  name                = "${var.key_vault_name}-${random_string.suffix.result}"
  location            = azurerm_resource_group.keyvault.location
  resource_group_name = azurerm_resource_group.keyvault.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  # Enable soft delete and purge protection for production scenarios
  soft_delete_retention_days = 7
  purge_protection_enabled   = false # Set to true for production

  # Network access configuration
  network_acls {
    default_action = "Allow" # For workshop purposes; restrict in production
    bypass         = "AzureServices"
  }

  tags = var.tags
}

# Access policy for current user/service principal
resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "List", "Create", "Delete", "Update", "Recover", "Backup", "Restore"
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
  ]

  certificate_permissions = [
    "Get", "List", "Create", "Delete", "Update", "Import"
  ]
}

# Access policy for managed identity
resource "azurerm_key_vault_access_policy" "managed_identity" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.app.principal_id

  secret_permissions = [
    "Get", "List"
  ]
}

# Sample secret for database connection string
resource "azurerm_key_vault_secret" "db_connection_string" {
  name         = "database-connection-string"
  value        = "Server=tcp:${var.database_server_name}.database.windows.net,1433;Database=${var.database_name};User ID=${var.database_admin_username};Password=${var.database_admin_password};Trusted_Connection=False;Encrypt=True;Connection Timeout=30;"
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_key_vault_access_policy.current_user]

  tags = var.tags
}

# Sample secret for application configuration
resource "azurerm_key_vault_secret" "app_config" {
  name         = "app-configuration"
  value        = jsonencode({
    environment = "workshop"
    debug_mode  = true
    api_version = "v1"
  })
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_key_vault_access_policy.current_user]

  tags = var.tags
}