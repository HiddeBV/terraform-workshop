# Terraform Registry Module Examples

This document provides practical examples of how to replace the local modules in this workshop with equivalent Terraform Registry modules. These examples build on your day 3 experience with the Terraform Registry.

## Network Module - Azure/network/azurerm

Replace the local network module with the official Azure network module:

### Local Module (Current)
```hcl
module "network" {
  source = "./modules/network"
  
  resource_group_name        = var.resource_group_name
  location                   = var.location
  vnet_name                  = var.vnet_name
  vnet_address_space         = var.vnet_address_space
  # ... other variables
}
```

### Registry Module (Alternative)
```hcl
module "network" {
  source  = "Azure/network/azurerm"
  version = "~> 5.3.0"
  
  resource_group_name = azurerm_resource_group.this.name
  vnet_name          = var.vnet_name
  address_space      = var.vnet_address_space
  
  subnet_prefixes = [
    var.app_subnet_address_prefix,
    var.data_subnet_address_prefix
  ]
  
  subnet_names = [
    var.app_subnet_name,
    var.data_subnet_name
  ]
  
  subnet_service_endpoints = {
    (var.app_subnet_name)  = ["Microsoft.Web"]
    (var.data_subnet_name) = ["Microsoft.Sql"]
  }
  
  tags = var.tags
}

# Additional resource group (registry module doesn't create this)
resource "azurerm_resource_group" "this" {
  name     = "${var.resource_group_name}-${formatdate("YYYYMMDD", timestamp())}"
  location = var.location
  tags     = var.tags
}
```

## Key Vault Module - Azure/key-vault/azurerm

Replace the local Key Vault module:

### Registry Module Alternative
```hcl
module "key_vault" {
  source  = "Azure/key-vault/azurerm"
  version = "~> 2.1.0"
  
  key_vault_name       = "${var.key_vault_name}-${random_string.suffix.result}"
  resource_group_name  = azurerm_resource_group.this.name
  location            = var.location
  
  # Enable RBAC instead of access policies
  enable_rbac_authorization = true
  
  # Soft delete configuration
  soft_delete_retention_days = 7
  purge_protection_enabled   = false
  
  # Network access
  network_acls = {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
  
  tags = var.tags
}

# Managed identity (create separately)
resource "azurerm_user_assigned_identity" "app" {
  name                = "${var.managed_identity_name}-${random_string.suffix.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags               = var.tags
}

# RBAC assignments (create separately)
resource "azurerm_role_assignment" "current_user" {
  scope                = module.key_vault.key_vault_id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}
```

## Application Gateway Module - Azure/application-gateway/azurerm

For more advanced scenarios, you could replace the basic App Service with Application Gateway:

```hcl
module "application_gateway" {
  source  = "Azure/application-gateway/azurerm"
  version = "~> 5.0.0"
  
  resource_group_name = azurerm_resource_group.this.name
  location           = var.location
  
  # Virtual network configuration
  virtual_network_name   = module.network.vnet_name
  virtual_network_rg     = azurerm_resource_group.this.name
  subnet_address_prefix  = "10.0.3.0/24"  # New subnet for App Gateway
  
  # Public IP configuration
  public_ip_allocation_method = "Static"
  public_ip_sku              = "Standard"
  
  # Application Gateway configuration
  sku = {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  
  # Backend pool pointing to App Service
  backend_address_pools = [
    {
      name  = "appservice-backend"
      fqdns = [azurerm_linux_web_app.main.default_hostname]
    }
  ]
  
  tags = var.tags
}
```

## Database Module - Azure/database/azurerm

For PostgreSQL instead of SQL Server:

```hcl
module "postgresql" {
  source  = "Azure/database/azurerm"
  version = "~> 1.1.0"
  
  resource_group_name = azurerm_resource_group.this.name
  location           = var.location
  
  # PostgreSQL specific configuration
  db_name                = var.database_name
  db_remote_port         = "5432"
  server_name           = "${var.sql_server_name}-${random_string.suffix.result}"
  
  # Version and performance
  server_version                   = "13"
  sku_name                        = "B_Gen5_1"
  storage_mb                      = 5120
  backup_retention_days           = 7
  geo_redundant_backup_enabled    = false
  auto_grow_enabled              = true
  
  # Security
  public_network_access_enabled  = false
  ssl_enforcement_enabled        = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  
  # Admin credentials
  administrator_login    = var.sql_admin_username
  administrator_password = random_password.sql_admin.result
  
  tags = var.tags
}
```

## Why Use Registry Modules?

### Advantages
- **Battle-tested**: Used by thousands of organizations
- **Best practices**: Implement Azure recommendations
- **Comprehensive**: Often include features you haven't thought of
- **Maintained**: Regular updates and bug fixes
- **Documented**: Extensive documentation and examples

### When to Use Local vs Registry Modules

**Use Local Modules When:**
- Learning and prototyping (like this workshop)
- Highly specific business requirements
- Need immediate customization
- Want full control over the code

**Use Registry Modules When:**
- Building production systems
- Want industry best practices
- Need comprehensive feature sets
- Prefer maintained, community-supported code

## Migration Strategy

1. **Start with Local**: Learn the concepts (as in this workshop)
2. **Identify Patterns**: Understand what resources you actually need
3. **Research Registry**: Find equivalent registry modules
4. **Test Migration**: Replace one module at a time
5. **Customize**: Add additional resources as needed

## Your Day 3 Connection

Since you already published modules to the Terraform Registry on day 3, you understand:
- Module versioning and semantic versioning
- Module documentation requirements
- Testing and validation processes
- Publishing workflows

Now you can **consume** those patterns in real infrastructure projects!

## Example: Complete Stack with Registry Modules

```hcl
# Use your own published network module from day 3
module "network" {
  source  = "app.terraform.io/your-org/network/azurerm"
  version = "~> 1.0.0"
  
  # Your module's interface
}

# Use community App Service module
module "app_service" {
  source  = "Azure/app-service/azurerm"  
  version = "~> 1.0.0"
  
  # Community module interface
}

# Use your custom security module
module "security" {
  source  = "app.terraform.io/your-org/security/azurerm"
  version = "~> 2.1.0"
  
  # Your organization's security standards
}
```

This approach lets you mix and match local modules, community registry modules, and your organization's private modules for maximum flexibility and reusability.