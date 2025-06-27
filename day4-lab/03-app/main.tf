terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
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
    # key                  = "app.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Data sources to get information from previous sprints
data "azurerm_resource_group" "network" {
  name = var.network_resource_group_name
}

data "azurerm_subnet" "app" {
  name                 = var.app_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.network.name
}

data "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  resource_group_name = var.keyvault_resource_group_name
}

data "azurerm_user_assigned_identity" "app" {
  name                = var.managed_identity_name
  resource_group_name = var.keyvault_resource_group_name
}

# Generate a random suffix for unique naming
resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

# Resource Group for App Service
resource "azurerm_resource_group" "app" {
  name     = "${var.resource_group_name}-${random_string.suffix.result}"
  location = var.location

  tags = var.tags
}

# App Service Plan
resource "azurerm_service_plan" "main" {
  name                = "${var.app_service_plan_name}-${random_string.suffix.result}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  
  os_type  = "Linux"
  sku_name = var.app_service_plan_sku

  tags = var.tags
}

# Linux Web App
resource "azurerm_linux_web_app" "main" {
  name                = "${var.app_service_name}-${random_string.suffix.result}"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    always_on = false  # Set to false for Basic tier
    
    application_stack {
      node_version = "18-lts"
    }
    
    # CORS configuration for development
    cors {
      allowed_origins = ["*"]
    }
  }

  # Assign managed identity
  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.app.id]
  }

  # App settings including Key Vault references
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITE_NODE_DEFAULT_VERSION"        = "18.17.0"
    "KEY_VAULT_URI"                       = data.azurerm_key_vault.main.vault_uri
    "AZURE_CLIENT_ID"                     = data.azurerm_user_assigned_identity.app.client_id
    "DB_CONNECTION_STRING"                = "@Microsoft.KeyVault(VaultName=${data.azurerm_key_vault.main.name};SecretName=database-connection-string)"
    "APP_CONFIG"                          = "@Microsoft.KeyVault(VaultName=${data.azurerm_key_vault.main.name};SecretName=app-configuration)"
  }

  # Network integration
  virtual_network_subnet_id = data.azurerm_subnet.app.id

  tags = var.tags
}

# Source control for Hello World app deployment
resource "azurerm_app_service_source_control" "main" {
  app_id                 = azurerm_linux_web_app.main.id
  repo_url               = var.source_control_repo_url
  branch                 = var.source_control_branch
  use_manual_integration = true
  use_mercurial          = false
}