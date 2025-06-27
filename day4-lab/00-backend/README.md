# Sprint 1 - Remote Backend

This module sets up the remote backend infrastructure for storing Terraform state in Azure Storage.

## Overview

Creates:
- Resource Group for backend infrastructure
- Storage Account for Terraform state
- Storage Container for state files
- Optional: Key Vault for storing sensitive backend configuration

## Prerequisites

- Azure CLI installed and authenticated
- Appropriate Azure permissions to create resources

## Usage

1. Initialize and apply the backend infrastructure:
```bash
terraform init
terraform plan
terraform apply
```

2. Configure the backend in your other modules using the outputs from this module.

## Resources Created

- `azurerm_resource_group.backend` - Resource group for backend resources
- `azurerm_storage_account.backend` - Storage account for Terraform state
- `azurerm_storage_container.tfstate` - Container for state files

## Outputs

- `storage_account_name` - Name of the storage account
- `container_name` - Name of the container for state files
- `resource_group_name` - Name of the resource group

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->