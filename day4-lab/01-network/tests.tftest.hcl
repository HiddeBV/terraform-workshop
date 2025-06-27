# Test file for the network module
# Tests the Virtual Network, subnets, and NSG setup

# Test variable validation and configuration
run "test_custom_variables" {
  command = plan

  variables {
    backend_resource_group_name    = "rg-terraform-backend-12345678"
    resource_group_name           = "rg-custom-network"
    location                      = "East US"
    vnet_name                     = "vnet-custom"
    vnet_address_space           = "172.16.0.0/16"
    app_subnet_address_prefix    = "172.16.1.0/24"
    data_subnet_address_prefix   = "172.16.2.0/24"
    tags = {
      Environment = "test"
      Purpose     = "custom-network"
    }
  }

  # This validates the configuration syntax and variable validation
  # Actual deployment would require Azure authentication
}

# Test network address space validation  
run "test_address_space_validation" {
  command = plan

  variables {
    backend_resource_group_name = "rg-terraform-backend-12345678"
    vnet_address_space         = "10.0.0.0/16"
    app_subnet_address_prefix  = "10.0.1.0/24"
    data_subnet_address_prefix = "10.0.2.0/24"
  }

  # Validates CIDR ranges are properly configured
}