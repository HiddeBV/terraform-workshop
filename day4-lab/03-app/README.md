# Sprint 4 - App Service Plan & App Service + Hello World Deploy

This lab teaches application hosting using **modular Terraform architecture**. Choose your learning path below!

## 🛤️ Choose Your Learning Path

### 🔨 Path 1: Build Your Own Module (Recommended)
**Best for**: Learning application architecture, VNet integration, managed identity patterns
- Start with starter templates in `modules/app-service-starter/`  
- Build secure App Service with managed identity step-by-step
- Learn application security and configuration patterns
- **Time**: 60-75 minutes | **Learning**: Maximum

### 🏭 Path 2: Use Complete Local Module
**Best for**: Focus on application deployment and integration patterns
- Use ready-made module in `modules/app-service/`
- Focus on application configuration and Key Vault integration
- Learn deployment and hosting patterns
- **Time**: 30-45 minutes | **Learning**: Moderate

### 🌐 Path 3: Use Registry Module
**Best for**: Production application hosting patterns
- Follow examples in [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md)
- Learn enterprise application hosting
- See production App Service configurations
- **Time**: 35-45 minutes | **Learning**: Different focus

> 💡 **Application Focus**: All paths deploy the same "Hello World" application with secure Key Vault integration!

## 📚 What You'll Create

All paths create the same application infrastructure:
- App Service Plan with appropriate sizing
- App Service (Web App) with managed identity
- VNet integration for secure outbound connectivity
- Application configuration with Key Vault integration
- Hello World application deployment

## 🚀 Getting Started

### For Path 1: Build Your Own Module

1. **Start with the starter template**:
   ```bash
   cd 03-app/modules/app-service-starter/
   cat README.md  # Read the application building guide
   ```

2. **Configure main.tf to use your module**:
   ```hcl
   module "app_service" {
     source = "./modules/app-service-starter"  # 👈 Point to your module
     
     # ... same variables as other paths
   }
   ```

3. **Build incrementally with application focus**:
   - Fill in `modules/app-service-starter/main.tf`
   - Focus on VNet integration and managed identity
   - Test with `terraform validate` and `terraform plan`

### For Path 2: Use Complete Module

1. **Use the provided module** (already configured):
   ```hcl
   module "app_service" {
     source = "./modules/app-service"  # 👈 Complete implementation
     
     # ... your configuration
   }
   ```

2. **Focus on application integration patterns**

### For Path 3: Use Registry Module

1. **Follow the registry examples**:
   - See [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md)
   - Replace the local module source with registry source

## Prerequisites

- Sprint 1 (00-backend) completed
- Sprint 2 (01-network) completed
- Sprint 3 (02-keyvault) completed
- Backend configuration set up

## Usage

1. Configure backend using outputs from Sprint 1
2. Initialize and apply:
```bash
terraform init
terraform plan  # Should show 3 resources being created
terraform apply
```

3. Test the deployment:
```bash
curl <app-url>  # Should return HTTP 200
```

## Definition of Done ✅

- `terraform apply` creates/updates resources and deployment succeeds
- Browser shows "Hello World – DB OK"
- `terraform apply` creates **3 resources**
- `curl <app-url>` returns HTTP 200
- Tests & docs pass

## Resources Created

This module creates exactly **3 resources** as required:
1. `azurerm_service_plan.main` - App Service Plan
2. `azurerm_linux_web_app.main` - Linux Web App
3. `azurerm_app_service_source_control.main` - Source control for app deployment

## Outputs

- `app_service_name` - Name of the App Service
- `app_service_url` - URL of the App Service
- `app_service_identity` - Managed identity of the App Service

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
| azurerm_service_plan | resource |
| azurerm_linux_web_app | resource |
| azurerm_app_service_source_control | resource |

## Inputs

| <a name="input_network_resource_group_name"></a> [network_resource_group_name](#input\_network_resource_group_name) | n/a | no |
| <a name="input_keyvault_resource_group_name"></a> [keyvault_resource_group_name](#input\_keyvault_resource_group_name) | n/a | no |
| <a name="input_vnet_name"></a> [vnet_name](#input\_vnet_name) | n/a | no |
| <a name="input_app_subnet_name"></a> [app_subnet_name](#input\_app_subnet_name) | n/a | no |
| <a name="input_key_vault_name"></a> [key_vault_name](#input\_key_vault_name) | n/a | no |
| <a name="input_managed_identity_name"></a> [managed_identity_name](#input\_managed_identity_name) | n/a | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input\_resource_group_name) | n/a | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | no |
| <a name="input_app_service_plan_name"></a> [app_service_plan_name](#input\_app_service_plan_name) | n/a | no |
| <a name="input_app_service_plan_sku"></a> [app_service_plan_sku](#input\_app_service_plan_sku) | n/a | no |
| <a name="input_app_service_name"></a> [app_service_name](#input\_app_service_name) | n/a | no |
| <a name="input_source_control_repo_url"></a> [source_control_repo_url](#input\_source_control_repo_url) | n/a | no |
| <a name="input_source_control_branch"></a> [source_control_branch](#input\_source_control_branch) | n/a | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | no |

## Outputs

| app_service_name | n/a |
| app_service_id | n/a |
| app_service_url | n/a |
| app_service_hostname | n/a |
| app_service_plan_name | n/a |
| app_service_plan_id | n/a |
| resource_group_name | n/a |
| app_service_identity | n/a |

<!-- END_TF_DOCS -->
