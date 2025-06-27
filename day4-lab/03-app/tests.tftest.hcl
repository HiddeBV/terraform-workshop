# Test file for the app module
# Tests the App Service Plan and App Service setup

# Test variable validation and configuration
run "test_custom_variables" {
  command = plan

  variables {
    network_resource_group_name = "rg-network-20240101"
    keyvault_resource_group_name = "rg-keyvault-12345678"
    app_subnet_name = "snet-app"
    vnet_name = "vnet-workshop"
    key_vault_name = "kv-workshop-12345678"
    managed_identity_name = "id-app-12345678"
    resource_group_name = "rg-custom-app"
    location = "East US"
    app_service_plan_name = "asp-custom"
    web_app_name = "app-custom"
    tags = {
      Environment = "test"
      Purpose = "custom-app"
    }
  }

  # This validates the configuration syntax
  # Actual deployment would require Azure authentication
}

# Test default configuration with required variables
run "test_default_variables" {
  command = plan

  variables {
    network_resource_group_name = "rg-network-20240101"
    keyvault_resource_group_name = "rg-keyvault-12345678"
    app_subnet_name = "snet-app"
    vnet_name = "vnet-workshop"
    key_vault_name = "kv-workshop-12345678"
    managed_identity_name = "id-app-12345678"
  }

  # Validates default variable configuration is syntactically correct
}