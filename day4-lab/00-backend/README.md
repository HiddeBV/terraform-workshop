# Sprint 1 - Remote Backend Bootstrap

This directory contains the bootstrap solution for creating the Terraform remote backend infrastructure in Azure Storage.

## Overview

The bootstrap approach solves the "chicken and egg" problem of creating a Terraform backend:
- You need a storage account to store Terraform state
- But creating the storage account with Terraform requires somewhere to store the state

## Solution

This directory provides a **bootstrap-only approach** that:

1. **Bootstrap Phase**: Uses Azure CLI to create the initial storage infrastructure
2. **Configuration Phase**: Provides backend configuration for all subsequent labs
3. **Integration Phase**: All other sprints (01-network, 02-keyvault, 03-app, 04-data) use this backend

## Prerequisites

- Azure CLI installed and authenticated (`az login`)
- Appropriate Azure permissions to create resources

## Usage

### Step 1: Run Bootstrap Script

```bash
cd bootstrap/
./bootstrap.sh
```

The script will:
- Create Resource Group for backend infrastructure
- Create Storage Account for Terraform state with versioning
- Create Storage Container for state files
- Generate configuration files for the next steps

### Step 2: Use Backend in Other Labs

After bootstrapping, all subsequent sprint directories will use this backend:

- **01-network**: Uses `key = "network.tfstate"`
- **02-keyvault**: Uses `key = "keyvault.tfstate"`  
- **03-app**: Uses `key = "app.tfstate"`
- **04-data**: Uses `key = "data.tfstate"`

Each lab includes a `backend.hcl.example` file that you'll configure with the output from the bootstrap script.

## Bootstrap Directory

The `bootstrap/` directory contains:
- `bootstrap.sh` - Automated bootstrap script for creating initial infrastructure
- `cleanup.sh` - Script to remove bootstrap resources  
- `README.md` - Detailed documentation for the bootstrap process

## Workshop Flow

1. **Complete Sprint 1**: Run the bootstrap script to create backend infrastructure
2. **Configure Labs 2-5**: Use the bootstrap outputs to configure backend for each subsequent sprint
3. **Team Collaboration**: All team members can now collaborate using the shared remote state

## Backend Configuration

After running the bootstrap, you'll get output like:
```
Resource Group: rg-terraform-backend-abc12345
Storage Account: stterraformabc12345
Container: tfstate
```

Use these values in the `backend.hcl` files for each sprint:
```hcl
resource_group_name  = "rg-terraform-backend-abc12345"
storage_account_name = "stterraformabc12345"  
container_name       = "tfstate"
key                  = "sprint-name.tfstate"  # Different for each sprint
```

## Next Steps

After completing the bootstrap:
1. Move to `01-network/` for Sprint 2
2. Configure the backend using the bootstrap outputs
3. Continue through the remaining sprints (02-keyvault, 03-app, 04-data)
4. All sprints will share the same backend infrastructure