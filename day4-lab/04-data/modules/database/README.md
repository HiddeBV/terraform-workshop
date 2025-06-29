# Database Module

This module creates Azure SQL Database infrastructure with private connectivity including:

- Resource Group for database resources
- Azure SQL Server with Azure AD authentication
- SQL Database with appropriate sizing
- Private Endpoint for secure access
- Private DNS Zone for name resolution
- VNet DNS zone linking
- Key Vault integration for secrets

## Module Usage

This is a local module that demonstrates secure database hosting with private connectivity.

### Required Inputs

- `resource_group_name` - Name prefix for the database resource group
- `location` - Azure region for deployment
- `sql_server_name` - Name of the SQL Server
- `sql_database_name` - Name of the SQL Database
- `sql_admin_username` - SQL Server admin username
- `azuread_admin_login` - Azure AD admin login name
- `azuread_admin_object_id` - Azure AD admin object ID
- `azuread_admin_tenant_id` - Azure AD admin tenant ID
- `data_subnet_id` - ID of the data subnet for private endpoint
- `vnet_id` - ID of the virtual network
- `key_vault_id` - ID of the Key Vault for storing secrets

### Optional Inputs

- `tags` - Map of tags to apply to resources

### Outputs

- `sql_server_id` - SQL Server resource ID
- `sql_server_fqdn` - SQL Server FQDN
- `sql_database_id` - Database resource ID
- `private_endpoint_id` - Private endpoint ID
- `resource_group_name` - Resource group name

## Security Features

- Private Endpoint connectivity (no public access)
- Azure AD authentication
- Generated secure passwords stored in Key Vault
- Private DNS resolution
- Network security rules