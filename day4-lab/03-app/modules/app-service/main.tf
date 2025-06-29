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
    identity_ids = [var.managed_identity_id]
  }

  # App settings including Key Vault references
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITE_NODE_DEFAULT_VERSION"        = "18.17.0"
    "KEY_VAULT_URI"                       = var.key_vault_uri
    "AZURE_CLIENT_ID"                     = var.managed_identity_client_id
    "DB_CONNECTION_STRING"                = "@Microsoft.KeyVault(VaultName=${var.key_vault_name};SecretName=database-connection-string)"
    "APP_CONFIG"                          = "@Microsoft.KeyVault(VaultName=${var.key_vault_name};SecretName=app-configuration)"
  }

  # Network integration
  virtual_network_subnet_id = var.app_subnet_id

  tags = var.tags
}

# Source control for Hello World app deployment
resource "azurerm_app_service_source_control" "main" {
  app_id                 = azurerm_linux_web_app.main.id
  repo_url               = var.source_control_repo_url
  branch                 = var.source_control_branch
}