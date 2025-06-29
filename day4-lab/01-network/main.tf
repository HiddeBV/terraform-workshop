terraform {
  required_version = ">= 1.12.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  
  # Backend configuration - update with your backend details from Sprint 1
  backend "azurerm" {
    # resource_group_name  = "rg-terraform-backend-xxxxxxxx"  # From Sprint 1 output
    # storage_account_name = "stterraformxxxxxxxx"            # From Sprint 1 output
    # container_name       = "tfstate"                        # From Sprint 1 output
    # key                  = "network.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Data source to get backend resource group info
data "azurerm_resource_group" "backend" {
  name = var.backend_resource_group_name
}

# Network Module - Demonstrates local module usage
module "network" {
  source = "./modules/network"

  # Pass variables to the module
  resource_group_name        = var.resource_group_name
  location                   = var.location
  vnet_name                  = var.vnet_name
  vnet_address_space         = var.vnet_address_space
  app_subnet_name            = var.app_subnet_name
  app_subnet_address_prefix  = var.app_subnet_address_prefix
  data_subnet_name           = var.data_subnet_name
  data_subnet_address_prefix = var.data_subnet_address_prefix
  nsg_name_prefix            = var.nsg_name_prefix
  tags                       = var.tags
}