# Sprint 2 - Network

This module creates the network foundation including VNet and Network Security Group (NSG) using **local modules** to demonstrate modular Terraform architecture.

## Overview

Creates:
- Virtual Network (VNet) with multiple subnets
- Network Security Group (NSG) with security rules
- Subnet associations with NSG
- Resource group for network resources

## Module Architecture

This lab demonstrates **local module usage** - one of the key patterns for organizing Terraform code:

```
01-network/
├── main.tf              # Root module that calls the network module
├── modules/
│   └── network/         # Local module
│       ├── main.tf      # Module resources
│       ├── variables.tf # Module inputs
│       ├── outputs.tf   # Module outputs
│       └── README.md    # Module documentation
├── variables.tf         # Root module variables
└── outputs.tf          # Root module outputs (pass-through from module)
```

### Why Use Modules?

- **Reusability**: The network module can be reused across environments
- **Organization**: Logical grouping of related resources
- **Abstraction**: Hide complexity behind a simple interface
- **Testing**: Modules can be tested independently
- **Maintainability**: Changes are isolated within modules

### Module Types Available

1. **Local Modules** (demonstrated here):
   ```hcl
   module "network" {
     source = "./modules/network"
     # ...
   }
   ```

2. **Registry Modules** (see [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md)):
   ```hcl
   module "network" {
     source  = "Azure/network/azurerm"
     version = "~> 5.0"
     # ...
   }
   ```

3. **Git Modules**:
   ```hcl
   module "network" {
     source = "git::https://github.com/org/terraform-modules.git//azure/network"
     # ...
   }
   ```

> 💡 **Next Steps**: After completing this workshop, check out [MODULE-USAGE-GUIDE.md](../MODULE-USAGE-GUIDE.md) and [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md) to learn about using Terraform Registry modules in production.

## Prerequisites

- Sprint 1 (00-backend) completed
- Backend configuration set up

## Usage

1. Configure backend using outputs from Sprint 1
2. Initialize and apply:
```bash
terraform init
terraform plan  # Should show 5 resources
terraform apply
```

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
