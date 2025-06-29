# App Service Module

This module creates Azure App Service infrastructure for hosting web applications including:

- Resource Group for App Service resources
- App Service Plan (Linux-based)
- Linux Web App with Node.js runtime
- Managed identity integration for secure access
- Key Vault references for configuration
- VNet integration for network security
- Source control deployment configuration

## Module Usage

This is a local module that demonstrates web application hosting patterns with security best practices.

### Required Inputs

- `resource_group_name` - Name prefix for the App Service resource group
- `location` - Azure region for deployment
- `app_service_plan_name` - Name of the App Service Plan
- `app_service_plan_sku` - SKU for the App Service Plan
- `app_service_name` - Name of the web application
- `managed_identity_id` - ID of the managed identity for Key Vault access
- `managed_identity_client_id` - Client ID of the managed identity
- `key_vault_uri` - URI of the Key Vault
- `key_vault_name` - Name of the Key Vault
- `app_subnet_id` - ID of the application subnet for VNet integration
- `source_control_repo_url` - Git repository URL for deployment
- `source_control_branch` - Git branch for deployment

### Optional Inputs

- `tags` - Map of tags to apply to resources

### Outputs

- `app_service_id` - App Service resource ID
- `app_service_name` - App Service name
- `app_service_url` - Application URL
- `app_service_plan_id` - App Service Plan ID
- `resource_group_name` - Resource group name

## Security Features

- VNet integration for network isolation
- Managed identity for Key Vault access
- Key Vault references for secure configuration
- HTTPS enforcement
- CORS configuration for development