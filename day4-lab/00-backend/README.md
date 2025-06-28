# Sprint 1 - Remote Backend

This module sets up the remote backend infrastructure for storing Terraform state in Azure Storage.

## Overview

Creates:
- Resource Group for backend infrastructure
- Storage Account for Terraform state
- Storage Container for state files
- Optional: Key Vault for storing sensitive backend configuration

## Bootstrap Problem & Solution

### The Challenge
Creating a Terraform backend creates a "chicken and egg" problem:
- You need a storage account to store Terraform state
- But you need to store Terraform state to create the storage account with Terraform

### The Solution
This module includes a **bootstrap solution** that solves this problem:

1. **Bootstrap Phase**: Use Azure CLI to create the initial storage infrastructure
2. **Import Phase**: Import the created resources into Terraform state
3. **Management Phase**: Terraform fully manages the backend going forward

## Prerequisites

- Azure CLI installed and authenticated
- Appropriate Azure permissions to create resources

## Usage

### Option 1: Bootstrap Approach (Recommended)

1. **Run the bootstrap script**:
```bash
cd bootstrap/
./bootstrap.sh
```

2. **Follow the generated migration instructions**:
```bash
# The script creates migration-instructions.md with detailed steps
cat migration-instructions.md
```

3. **Complete the import and migration process** as outlined in the instructions

### Option 2: Direct Terraform (Manual Backend Setup)

1. Manually create a storage account via Azure Portal or CLI
2. Configure the backend in your Terraform configuration
3. Initialize and apply:
```bash
terraform init
terraform plan
terraform apply
```

### Option 3: Local State Initially

1. Initialize and apply with local state:
```bash
terraform init
terraform plan
terraform apply
```

2. Configure backend and migrate state:
```bash
# Add backend configuration to main.tf
terraform init -migrate-state
```

## Resources Created

- `azurerm_resource_group.backend` - Resource group for backend resources
- `azurerm_storage_account.backend` - Storage account for Terraform state
- `azurerm_storage_container.tfstate` - Container for state files

## Bootstrap Directory

The `bootstrap/` directory contains:
- `bootstrap.sh` - Automated bootstrap script for creating initial infrastructure
- `cleanup.sh` - Script to remove bootstrap resources
- `README.md` - Detailed documentation for the bootstrap process

## Outputs

- `storage_account_name` - Name of the storage account
- `container_name` - Name of the container for state files
- `resource_group_name` - Name of the resource group

## Workshop Flow

In the workshop context, this module demonstrates:
1. The bootstrap problem with Terraform backends
2. How to solve it with automation
3. Best practices for state management
4. Setting up infrastructure for subsequent sprints

## Next Steps

After completing this sprint:
1. Use the backend outputs to configure other modules
2. All subsequent sprints will use this remote backend
3. Team members can collaborate on the same Terraform state

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->