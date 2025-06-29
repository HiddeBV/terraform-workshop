# Sprint 3 - Key Vault & IAM

This lab teaches secure secrets management using **modular Terraform architecture**. Choose your learning path below!

## 🛤️ Choose Your Learning Path

### 🔨 Path 1: Build Your Own Module (Recommended)
**Best for**: Learning security patterns, understanding RBAC and managed identities
- Start with starter templates in `modules/keyvault-starter/`  
- Build secure Key Vault with RBAC step-by-step
- Learn security best practices hands-on
- **Time**: 45-60 minutes | **Learning**: Maximum

### 🏭 Path 2: Use Complete Local Module
**Best for**: Focus on security integration patterns, faster completion
- Use ready-made module in `modules/keyvault/`
- Focus on Key Vault integration with applications
- Learn RBAC and managed identity patterns
- **Time**: 15-30 minutes | **Learning**: Moderate

### 🌐 Path 3: Use Registry Module
**Best for**: Production security patterns, community best practices
- Follow examples in [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md)
- Learn production Key Vault configurations
- See enterprise security patterns
- **Time**: 20-30 minutes | **Learning**: Different focus

> 💡 **Security Focus**: All paths implement the same secure RBAC-based architecture!

## 📚 What You'll Create

All paths create the same secure infrastructure:
- Azure Key Vault with RBAC authorization enabled
- Role-based access control with least privilege principles
- Sample secrets for the workshop
- Managed identity for secure access

## Security Model

This workshop uses **RBAC (Role-Based Access Control)** instead of access policies for enhanced security:

- **Current User/Service Principal**: `Key Vault Secrets Officer` role
  - Can create, read, update, and delete secrets
  - Cannot modify access control or vault settings
- **Managed Identity (for applications)**: `Key Vault Secrets User` role  
  - Can only read secrets (least privilege)
  - Perfect for application access to secrets

## 🚀 Getting Started

### For Path 1: Build Your Own Module

1. **Start with the starter template**:
   ```bash
   cd 02-keyvault/modules/keyvault-starter/
   cat README.md  # Read the security building guide
   ```

2. **Configure main.tf to use your module**:
   ```hcl
   module "keyvault" {
     source = "./modules/keyvault-starter"  # 👈 Point to your module
     
     # ... same variables as other paths
   }
   ```

3. **Build incrementally with security focus**:
   - Fill in `modules/keyvault-starter/main.tf`
   - Focus on RBAC and managed identity
   - Test with `terraform validate` and `terraform plan`

### For Path 2: Use Complete Module

1. **Use the provided module** (already configured):
   ```hcl
   module "keyvault" {
     source = "./modules/keyvault"  # 👈 Complete implementation
     
     # ... your configuration
   }
   ```

2. **Focus on security integration patterns**

### For Path 3: Use Registry Module

1. **Follow the registry examples**:
   - See [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md)
   - Replace the local module source with registry source

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

- `azurerm_key_vault.main` - Main Key Vault with RBAC enabled
- `azurerm_role_assignment.*` - RBAC role assignments for users and applications
- `azurerm_key_vault_secret.*` - Sample secrets for workshop
- `azurerm_user_assigned_identity.app` - Managed identity for applications

## Outputs

- `key_vault_id` - ID of the Key Vault
- `key_vault_uri` - URI of the Key Vault
- `managed_identity_id` - ID of the managed identity
- `managed_identity_client_id` - Client ID of the managed identity

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |

## Resources

| random_string | resource |
| azurerm_resource_group | resource |
| azurerm_user_assigned_identity | resource |
| azurerm_key_vault | resource |
| azurerm_role_assignment | resource |
| azurerm_role_assignment | resource |
| azurerm_key_vault_secret | resource |
| azurerm_key_vault_secret | resource |

## Inputs

| <a name="input_network_resource_group_name"></a> [network_resource_group_name](#input\_network_resource_group_name) | n/a | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input\_resource_group_name) | n/a | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | no |
| <a name="input_key_vault_name"></a> [key_vault_name](#input\_key_vault_name) | n/a | no |
| <a name="input_managed_identity_name"></a> [managed_identity_name](#input\_managed_identity_name) | n/a | no |
| <a name="input_database_server_name"></a> [database_server_name](#input\_database_server_name) | n/a | no |
| <a name="input_database_name"></a> [database_name](#input\_database_name) | n/a | no |
| <a name="input_database_admin_username"></a> [database_admin_username](#input\_database_admin_username) | n/a | no |
| <a name="input_database_admin_password"></a> [database_admin_password](#input\_database_admin_password) | n/a | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | no |

## Outputs

| key_vault_id | n/a |
| key_vault_name | n/a |
| key_vault_uri | n/a |
| resource_group_name | n/a |
| managed_identity_id | n/a |
| managed_identity_client_id | n/a |
| managed_identity_principal_id | n/a |
| database_connection_string_secret_name | n/a |
| app_config_secret_name | n/a |

<!-- END_TF_DOCS -->
