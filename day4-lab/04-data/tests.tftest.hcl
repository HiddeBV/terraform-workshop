# Test file for the data module
# Tests the Azure SQL Server, Database, and Private Endpoint setup

# Test variable validation and configuration
run "test_custom_variables" {
  command = plan

  variables {
    network_resource_group_name = "rg-network-20240101"
    data_subnet_name = "snet-data"
    vnet_name = "vnet-workshop"
    resource_group_name = "rg-custom-data"
    location = "East US"
    sql_server_name = "sql-custom"
    database_name = "customdb"
    tags = {
      Environment = "test"
      Purpose = "custom-data"
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
    data_subnet_name = "snet-data"
    vnet_name = "vnet-workshop"
  }

  # Validates default variable configuration is syntactically correct
}