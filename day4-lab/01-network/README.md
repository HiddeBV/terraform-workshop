# Sprint 2 - Network

This lab teaches network infrastructure using **modular Terraform architecture**. Choose your learning path below!

## 🛤️ Choose Your Learning Path

### 🔨 Path 1: Build Your Own Module (Recommended)
**Best for**: Learning module development, understanding every component
- Start with starter templates in `modules/network-starter/`  
- Build resources step-by-step with guided hints
- Learn by doing - understand every line of code
- **Time**: 45-60 minutes | **Learning**: Maximum

### 🏭 Path 2: Use Complete Local Module
**Best for**: Focus on module usage patterns, faster completion
- Use ready-made module in `modules/network/`
- Focus on module composition and configuration  
- Learn module interfaces and integration
- **Time**: 15-30 minutes | **Learning**: Moderate

### 🌐 Path 3: Use Registry Module
**Best for**: Production patterns, community best practices
- Follow examples in [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md)
- Learn how to integrate external modules
- See production-ready implementations
- **Time**: 20-30 minutes | **Learning**: Different focus

> 💡 **New to modules?** Start with Path 1 to build foundational knowledge, then explore the others!

## 📚 What You'll Create

All paths create the same infrastructure:
- Virtual Network (VNet) with multiple subnets
- Network Security Group (NSG) with security rules
- Subnet associations with NSG
- Resource group for network resources

## Module Architecture

This lab demonstrates **modular Terraform patterns** for organizing infrastructure code:

```
01-network/
├── main.tf              # Root module - configure to use your chosen path
├── modules/
│   ├── network-starter/ # 🔨 Build your own module (empty templates)
│   │   ├── main.tf      # TODO: Add your resources here
│   │   ├── variables.tf # Module inputs (provided)
│   │   ├── outputs.tf   # Module outputs (template)
│   │   └── README.md    # Building guide
│   └── network/         # 🏭 Complete local module (ready to use)
│       ├── main.tf      # All resources implemented
│       ├── variables.tf # Module inputs
│       ├── outputs.tf   # Module outputs
│       └── README.md    # Module documentation
├── variables.tf         # Root module variables
└── outputs.tf          # Root module outputs
```

## 🚀 Getting Started

### For Path 1: Build Your Own Module

1. **Start with the starter template**:
   ```bash
   cd 01-network/modules/network-starter/
   cat README.md  # Read the building guide
   ```

2. **Configure main.tf to use your module**:
   ```hcl
   module "network" {
     source = "./modules/network-starter"  # 👈 Point to your module
     
     # ... same variables as other paths
   }
   ```

3. **Build incrementally**:
   - Fill in `modules/network-starter/main.tf`
   - Test with `terraform validate` and `terraform plan`
   - Aim for exactly 6 resources

### For Path 2: Use Complete Module

1. **Use the provided module** (already configured):
   ```hcl
   module "network" {
     source = "./modules/network"  # 👈 Complete implementation
     
     # ... your configuration
   }
   ```

2. **Focus on configuration and usage patterns**

### For Path 3: Use Registry Module

1. **Follow the registry examples**:
   - See [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md)
   - Replace the local module source with registry source

## Prerequisites

- Sprint 1 (00-backend) completed
- Backend configuration set up

## Usage

### Step 1: Choose Your Path
Decide whether to build your own module, use the complete module, or try registry modules.

### Step 2: Configure Backend
Use outputs from Sprint 1 to configure your backend in `main.tf`.

### Step 3: Initialize and Plan
```bash
terraform init
terraform plan  # Should show exactly 6 resources for all paths
```

### Step 4: Apply
```bash
terraform apply
```

## Resources Created

All paths create exactly **6 resources**:
1. `azurerm_resource_group.network` - Resource group for network resources
2. `azurerm_virtual_network.main` - Main VNet
3. `azurerm_subnet.app` - Subnet for App Service (with delegation)
4. `azurerm_subnet.data` - Subnet for database (private endpoint ready)
5. `azurerm_network_security_group.app` - NSG for application tier
6. `azurerm_subnet_network_security_group_association.app` - NSG association

## Learning Outcomes

### Build Your Own Path ✨
- Understanding of each resource and its purpose
- Experience with Terraform resource syntax
- Knowledge of Azure networking concepts
- Confidence in module development

### Complete Module Path ✨
- Focus on module interfaces and composition
- Understanding of module input/output patterns
- Faster completion with learning about usage

### Registry Module Path ✨
- Experience with external module integration
- Understanding of versioning and dependencies
- Production-ready patterns and configurations

## 💡 Pro Tips

- **Start Simple**: If building your own, implement one resource at a time
- **Test Frequently**: Use `terraform validate` and `terraform plan` often
- **Compare Approaches**: Try multiple paths to see the differences
- **Read Documentation**: Use Azure docs and Terraform provider docs
- **Ask for Help**: Check the starter module README for hints

## Resources Created

This module creates exactly **5 resources** as required:
1. `azurerm_virtual_network.main` - Main VNet
2. `azurerm_subnet.app` - Subnet for App Service
3. `azurerm_subnet.data` - Subnet for database
4. `azurerm_network_security_group.app` - NSG for application tier
5. `azurerm_subnet_network_security_group_association.app` - NSG association

## Outputs

- `vnet_name` - Name of the virtual network
- `vnet_id` - ID of the virtual network
- `app_subnet_id` - ID of the application subnet
- `data_subnet_id` - ID of the data subnet
- `nsg_id` - ID of the network security group

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

| azurerm_resource_group | resource |
| azurerm_virtual_network | resource |
| azurerm_subnet | resource |
| azurerm_subnet | resource |
| azurerm_network_security_group | resource |
| azurerm_subnet_network_security_group_association | resource |

## Inputs

| <a name="input_backend_resource_group_name"></a> [backend_resource_group_name](#input\_backend_resource_group_name) | n/a | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input\_resource_group_name) | n/a | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | no |
| <a name="input_vnet_name"></a> [vnet_name](#input\_vnet_name) | n/a | no |
| <a name="input_vnet_address_space"></a> [vnet_address_space](#input\_vnet_address_space) | n/a | no |
| <a name="input_app_subnet_name"></a> [app_subnet_name](#input\_app_subnet_name) | n/a | no |
| <a name="input_app_subnet_address_prefix"></a> [app_subnet_address_prefix](#input\_app_subnet_address_prefix) | n/a | no |
| <a name="input_data_subnet_name"></a> [data_subnet_name](#input\_data_subnet_name) | n/a | no |
| <a name="input_data_subnet_address_prefix"></a> [data_subnet_address_prefix](#input\_data_subnet_address_prefix) | n/a | no |
| <a name="input_nsg_name_prefix"></a> [nsg_name_prefix](#input\_nsg_name_prefix) | n/a | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | no |

## Outputs

| vnet_name | n/a |
| vnet_id | n/a |
| resource_group_name | n/a |
| app_subnet_id | n/a |
| app_subnet_name | n/a |
| data_subnet_id | n/a |
| data_subnet_name | n/a |
| nsg_id | n/a |
| nsg_name | n/a |

<!-- END_TF_DOCS -->
