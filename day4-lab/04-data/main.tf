terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
  
  # Backend configuration - update with your backend details from Sprint 1
  backend "azurerm" {
    # resource_group_name  = "rg-terraform-backend-xxxxxxxx"  # From Sprint 1 output
    # storage_account_name = "stterraformxxxxxxxx"            # From Sprint 1 output
    # container_name       = "tfstate"                        # From Sprint 1 output
    # key                  = "data.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Data sources to get information from previous sprints
data "azurerm_resource_group" "network" {
  name = var.network_resource_group_name
}

data "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.network.name
}

data "azurerm_subnet" "data" {
  name                 = var.data_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.network.name
}

# Generate a random suffix for unique naming
resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

# Generate a random password for SQL admin
resource "random_password" "sql_admin" {
  length  = 16
  special = true
}

# Resource Group for Database resources
resource "azurerm_resource_group" "data" {
  name     = "${var.resource_group_name}-${random_string.suffix.result}"
  location = var.location

  tags = var.tags
}

# SQL Server
resource "azurerm_mssql_server" "main" {
  name                = "${var.sql_server_name}-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.data.name
  location            = azurerm_resource_group.data.location
  version             = "12.0"

  administrator_login          = var.sql_admin_username
  administrator_login_password = random_password.sql_admin.result

  # Disable public network access
  public_network_access_enabled = false

  # Enable Microsoft Defender for SQL
  azuread_administrator {
    login_username = var.azuread_admin_login
    object_id      = var.azuread_admin_object_id
    tenant_id      = var.azuread_admin_tenant_id
  }

  tags = var.tags
}

# SQL Database
resource "azurerm_mssql_database" "main" {
  name           = var.sql_database_name
  server_id      = azurerm_mssql_server.main.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "Basic"
  zone_redundant = false

  tags = var.tags
}

# Private DNS Zone for SQL Server
resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.data.name

  tags = var.tags
}

# Link Private DNS Zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "sql" {
  name                  = "sql-dns-link"
  resource_group_name   = azurerm_resource_group.data.name
  private_dns_zone_name = azurerm_private_dns_zone.sql.name
  virtual_network_id    = data.azurerm_virtual_network.main.id
  registration_enabled  = false

  tags = var.tags
}

# Private Endpoint for SQL Server
resource "azurerm_private_endpoint" "sql" {
  name                = "${var.private_endpoint_name}-${random_string.suffix.result}"
  location            = azurerm_resource_group.data.location
  resource_group_name = azurerm_resource_group.data.name
  subnet_id           = data.azurerm_subnet.data.id

  private_service_connection {
    name                           = "sql-private-connection"
    private_connection_resource_id = azurerm_mssql_server.main.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql.id]
  }

  tags = var.tags
}

# Network security rule to deny public SQL access (additional security)
resource "azurerm_network_security_rule" "deny_sql_public" {
  name                        = "DenySQL"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "1433"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.network.name
  network_security_group_name = var.nsg_name
}