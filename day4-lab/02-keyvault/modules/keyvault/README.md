# Key Vault Module

This module creates Azure Key Vault infrastructure for secure secret management including:

- Resource Group for Key Vault resources
- Azure Key Vault with RBAC authorization
- User-assigned managed identity for applications
- RBAC role assignments for secret access
- Sample secrets for database connection and app configuration

## Module Usage

This is a local module that demonstrates secure secret management patterns.

### Required Inputs

- `resource_group_name` - Name prefix for the Key Vault resource group
- `location` - Azure region for deployment
- `key_vault_name` - Name of the Key Vault (max 16 chars)
- `managed_identity_name` - Name of the managed identity
- `database_server_name` - Database server name for connection string
- `database_name` - Database name
- `database_admin_username` - Database admin username
- `database_admin_password` - Database admin password

### Optional Inputs

- `tags` - Map of tags to apply to resources

### Outputs

- `key_vault_id` - Key Vault resource ID
- `key_vault_name` - Key Vault name
- `key_vault_uri` - Key Vault URI
- `managed_identity_id` - Managed identity ID
- `managed_identity_client_id` - Managed identity client ID
- Secret names for application reference

## Security Features

- RBAC-based access control
- Managed identity for secure access
- Soft delete protection
- Network ACL configuration