# Sprint 2 - Network

This module creates the network foundation including VNet and Network Security Group (NSG).

## Overview

Creates:
- Virtual Network (VNet) with multiple subnets
- Network Security Group (NSG) with security rules
- Subnet associations with NSG
- Public IP for potential future use

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
<!-- END_TF_DOCS -->