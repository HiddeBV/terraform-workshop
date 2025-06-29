# Bootstrap Solution for Terraform Backend

This directory contains a bootstrap solution to solve the chicken and egg problem of creating a Terraform remote backend.

## The Problem

When using Terraform with a remote backend (Azure Storage), you face a classic bootstrap problem:
- To use remote state, you need an Azure Storage Account
- But to create the Storage Account with Terraform, you need somewhere to store the state
- You can't create the backend infrastructure with Terraform if you need that same infrastructure to store Terraform's state

## The Solution

This bootstrap approach solves the problem by:

1. **Initial Bootstrap**: Use Azure CLI to create the storage account infrastructure
2. **Import to Terraform**: Import the created resources into Terraform state
3. **Migrate to Remote**: Configure Terraform to use the remote backend
4. **Full Management**: Now Terraform fully manages the backend infrastructure

## Files

- `bootstrap.sh` - Main bootstrap script that creates the Azure infrastructure
- `README.md` - This documentation file

## Prerequisites

- Azure CLI installed and configured (`az login`)
- Appropriate Azure permissions to create:
  - Resource Groups
  - Storage Accounts
  - Storage Containers
- Bash shell (Linux/macOS/WSL)

## Usage

### Step 1: Run Bootstrap Script

```bash
cd day4-lab/00-backend/bootstrap
./bootstrap.sh
```

The script will:
- Check prerequisites (Azure CLI, login status)
- Generate unique names for resources
- Create Resource Group
- Create Storage Account with versioning enabled
- Create Storage Container
- Generate configuration files for next steps

### Step 2: Follow Migration Instructions

The script generates a `migration-instructions.md` file with detailed steps to:
1. Import the created resources into Terraform
2. Configure the remote backend
3. Migrate local state to remote storage

### Step 3: Verify Setup

After following the migration instructions, your Terraform backend will be:
- Fully managed by Terraform code
- Using remote state storage in Azure
- Ready for team collaboration

## Generated Files

The bootstrap script creates several files to help with the migration:

- `backend-config.tf` - Backend configuration block
- `terraform.tfvars` - Variables file with created resource names
- `migration-instructions.md` - Step-by-step migration guide

## Benefits

This approach provides:

1. **Automation**: Reduces manual steps and human error
2. **Repeatability**: Can be run multiple times for different environments
3. **Documentation**: Clear instructions for the migration process
4. **Unique Naming**: Automatically generates unique resource names
5. **Security**: Storage account created with appropriate security settings

## Alternative Approaches

Other common solutions to the bootstrap problem include:

1. **Manual Creation**: Create storage account manually via Azure Portal
2. **ARM Templates**: Use ARM/Bicep templates for initial bootstrap
3. **Terraform Cloud**: Use Terraform Cloud for remote state management
4. **Multiple Backends**: Use different backends for different environments

This script-based approach is chosen for its simplicity and educational value in a workshop setting.

## Troubleshooting

### Common Issues

1. **Azure CLI not logged in**:
   ```bash
   az login
   ```

2. **Insufficient permissions**:
   Ensure your Azure account has Contributor access to the subscription

3. **Resource name conflicts**:
   The script generates unique suffixes to avoid conflicts, but you can modify the prefixes in the script if needed

4. **Import failures**:
   Check the resource IDs in the migration instructions match your subscription

### Getting Help

If you encounter issues:
1. Check the Azure portal to verify resources were created
2. Review the generated migration instructions
3. Use `terraform import --help` for import command syntax
4. Check Azure CLI connection with `az account show`

## Security Considerations

The bootstrap script creates resources with appropriate security settings:
- Storage account blocks public blob access
- Container access is set to private
- Blob versioning is enabled for state file protection
- Resources are tagged for identification and management

## Cleanup

To remove the bootstrap infrastructure:

```bash
# If using the generated resource group name
az group delete --name <resource-group-name> --yes --no-wait

# Or use Terraform after import/migration
terraform destroy
```

Remember to remove any backend configuration from your Terraform files before destroying the backend infrastructure.