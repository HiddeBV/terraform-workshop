# Network Module

This module creates the foundational network infrastructure for the workshop including:

- Resource Group for network resources
- Virtual Network with configurable address space
- Application subnet with App Service delegation
- Data subnet with private endpoint support
- Network Security Group with HTTP/HTTPS rules
- NSG association with application subnet

## Module Usage

This is a local module that demonstrates how to organize Terraform resources into reusable components.

### Required Inputs

- `resource_group_name` - Name prefix for the network resource group
- `location` - Azure region for deployment
- `vnet_name` - Name of the virtual network
- `vnet_address_space` - CIDR block for the VNet
- `app_subnet_name` - Name of the application subnet
- `app_subnet_address_prefix` - CIDR block for app subnet
- `data_subnet_name` - Name of the data subnet  
- `data_subnet_address_prefix` - CIDR block for data subnet
- `nsg_name_prefix` - Prefix for NSG names

### Optional Inputs

- `tags` - Map of tags to apply to resources

### Outputs

- `vnet_id` - Virtual network resource ID
- `resource_group_name` - Network resource group name
- `app_subnet_id` - Application subnet ID
- `data_subnet_id` - Data subnet ID
- `nsg_id` - Network security group ID