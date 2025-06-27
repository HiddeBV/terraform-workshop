# Sprint 3 - Key Vault & IAM

This module creates Azure Key Vault with proper access policies and secrets management.

## Overview

Creates:
- Azure Key Vault with appropriate configurations
- Access policies for the current user and application
- Sample secrets for the workshop
- Managed identity for secure access

## Prerequisites

- Sprint 1 (00-backend) completed
- Sprint 2 (01-network) completed
- Backend configuration set up

## Usage

1. Configure backend using outputs from Sprint 1
2. Initialize and apply:
```bash
terraform init
terraform plan
terraform apply
```

## Resources Created

- `azurerm_key_vault.main` - Main Key Vault
- `azurerm_key_vault_access_policy.*` - Access policies for users and applications
- `azurerm_key_vault_secret.*` - Sample secrets for workshop
- `azurerm_user_assigned_identity.app` - Managed identity for applications

## Outputs

- `key_vault_id` - ID of the Key Vault
- `key_vault_uri` - URI of the Key Vault
- `managed_identity_id` - ID of the managed identity
- `managed_identity_client_id` - Client ID of the managed identity

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->