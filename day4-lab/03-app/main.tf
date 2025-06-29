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

# App Service Module - Demonstrates local module usage for web applications
module "app_service" {
  source = "./modules/app-service"

  # Pass variables to the module
  resource_group_name           = var.resource_group_name
  location                      = var.location
  app_service_plan_name         = var.app_service_plan_name
  app_service_plan_sku          = var.app_service_plan_sku
  app_service_name              = var.app_service_name
  managed_identity_id           = data.azurerm_user_assigned_identity.app.id
  managed_identity_client_id    = data.azurerm_user_assigned_identity.app.client_id
  key_vault_uri                 = data.azurerm_key_vault.main.vault_uri
  key_vault_name                = data.azurerm_key_vault.main.name
  app_subnet_id                 = data.azurerm_subnet.app.id
  source_control_repo_url       = var.source_control_repo_url
  source_control_branch         = var.source_control_branch
  tags                          = var.tags
}

