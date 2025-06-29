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
    # key                  = "data.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Data sources to get information from previous sprints
data "azurerm_resource_group" "network" {
  name = var.network_resource_group_name
}

data "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.network.name
}

data "azurerm_subnet" "data" {
  name                 = var.data_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.network.name
}

data "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  resource_group_name = var.keyvault_resource_group_name
}

# Database Module - Demonstrates local module usage for data tier
module "database" {
  source = "./modules/database"

  # Pass variables to the module
  resource_group_name       = var.resource_group_name
  location                  = var.location
  sql_server_name           = var.sql_server_name
  sql_database_name         = var.sql_database_name
  sql_admin_username        = var.sql_admin_username
  azuread_admin_login       = var.azuread_admin_login
  azuread_admin_object_id   = var.azuread_admin_object_id
  azuread_admin_tenant_id   = var.azuread_admin_tenant_id
  data_subnet_id            = data.azurerm_subnet.data.id
  vnet_id                   = data.azurerm_virtual_network.main.id
  key_vault_id              = data.azurerm_key_vault.main.id
  tags                      = var.tags
}
