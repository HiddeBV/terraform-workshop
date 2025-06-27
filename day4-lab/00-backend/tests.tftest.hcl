# Test file for the backend module
# Tests the Terraform backend infrastructure setup

# Test variable validation
run "test_variable_validation" {
  command = plan

  variables {
    storage_account_prefix = "test123456789012345"  # Too long (>16 chars)
  }
  
  expect_failures = [
    var.storage_account_prefix,
  ]
}

# Test with valid variables
run "test_valid_configuration" {
  command = plan

  variables {
    resource_group_name      = "rg-test-backend"
    location                = "West Europe"
    storage_account_prefix  = "sttest"
    container_name          = "tfstate"
    tags = {
      Environment = "test"
      Purpose     = "backend"
    }
  }

  # This test validates the configuration is syntactically correct
  # It will fail due to Azure auth, but that's expected for validation tests
}

# Test storage account prefix validation with invalid characters
run "test_invalid_storage_prefix" {
  command = plan

  variables {
    storage_account_prefix = "ST-Invalid"  # Contains uppercase and special chars
  }
  
  expect_failures = [
    var.storage_account_prefix,
  ]
}

# Test valid storage account prefix
run "test_valid_storage_prefix" {
  command = plan

  variables {
    storage_account_prefix = "stvalid123"
  }
  
  # This should not fail validation (only Azure auth will fail)
}