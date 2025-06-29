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

# Data source to get network resource group info
data "azurerm_resource_group" "network" {
  name = var.network_resource_group_name
}

# Key Vault Module - Demonstrates local module usage for secure secret management
module "keyvault" {
  source = "./modules/keyvault"

  # Pass variables to the module
  resource_group_name        = var.resource_group_name
  location                   = var.location
  key_vault_name             = var.key_vault_name
  managed_identity_name      = var.managed_identity_name
  database_server_name       = var.database_server_name
  database_name              = var.database_name
  database_admin_username    = var.database_admin_username
  database_admin_password    = var.database_admin_password
  tags                       = var.tags
}