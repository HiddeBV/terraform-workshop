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
}

provider "azurerm" {
  features {}
}

# Generate a random suffix for unique naming
resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

# Resource Group for backend infrastructure
resource "azurerm_resource_group" "backend" {
  name     = "${var.resource_group_name}-${random_string.suffix.result}"
  location = var.location

  tags = var.tags
}

# Storage Account for Terraform state
resource "azurerm_storage_account" "backend" {
  name                = "${var.storage_account_prefix}${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.backend.name
  location            = azurerm_resource_group.backend.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  
  # Enable versioning for state file protection
  blob_properties {
    versioning_enabled = true
  }

  tags = var.tags
}

# Container for Terraform state files
resource "azurerm_storage_container" "tfstate" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.backend.name
  container_access_type = "private"
}