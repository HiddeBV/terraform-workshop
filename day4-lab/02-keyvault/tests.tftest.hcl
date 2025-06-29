# Test file for the keyvault module
# Tests the Key Vault, managed identity, and access policies

# Test variable validation and configuration
run "test_custom_variables" {
  command = plan

  variables {
    network_resource_group_name = "rg-network-20240101"
    resource_group_name        = "rg-custom-keyvault"
    location                   = "East US"
    key_vault_name_prefix     = "kv-custom"
    managed_identity_name     = "id-custom-app"
    tags = {
      Environment = "test"
      Purpose     = "custom-keyvault"
    }
  }

  # This validates the configuration syntax
  # Actual deployment would require Azure authentication
}

# Test default configuration
run "test_default_variables" {
  command = plan

  variables {
    network_resource_group_name = "rg-network-20240101"
  }

  # Validates default variable configuration is syntactically correct
}