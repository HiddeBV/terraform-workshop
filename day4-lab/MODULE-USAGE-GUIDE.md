# Module Usage Guide

This guide demonstrates different ways to use Terraform modules, building on the patterns established in day 3 of the course where you already published modules to the Terraform Registry.

## Module Types and Sources

### 1. Local Modules (Demonstrated in Labs)

Local modules are stored in the same repository as your root configuration. Perfect for:
- Project-specific components
- Development and testing
- Custom business logic

```hcl
module "network" {
  source = "./modules/network"
  
  resource_group_name = var.resource_group_name
  location           = var.location
  # ... other variables
}
```

**Benefits:**
- ✅ Full control over module code
- ✅ Easy debugging and modification  
- ✅ Version control with your project
- ✅ No external dependencies

**Use when:**
- Building project-specific infrastructure
- Prototyping new patterns
- Need immediate customization

### 2. Terraform Registry Modules

Public modules from the official Terraform Registry. You already have experience with these from day 3!

```hcl
module "network" {
  source  = "Azure/network/azurerm"
  version = "~> 5.0"
  
  resource_group_name = var.resource_group_name
  location           = var.location
  vnet_name          = var.vnet_name
  # ... registry module specific variables
}
```

**Benefits:**
- ✅ Community tested and maintained
- ✅ Semantic versioning
- ✅ Comprehensive documentation
- ✅ Best practices built-in

**Use when:**
- Need battle-tested, standard components
- Want to follow Azure best practices
- Building production systems
- Need comprehensive feature sets

### 3. Private Registry Modules

Your own modules published to a private registry (like you did on day 3):

```hcl
module "custom_network" {
  source  = "app.terraform.io/your-org/network/azurerm"
  version = "~> 1.0"
  
  # Your custom module interface
}
```

### 4. Git Repository Modules

Modules stored in git repositories:

```hcl
module "network" {
  source = "git::https://github.com/your-org/terraform-modules.git//azure/network?ref=v1.0.0"
  
  # Module variables
}
```

## Best Practices from the Workshop

### Module Design Principles

1. **Single Responsibility**: Each module should have one clear purpose
   ```
   ✅ modules/network/     - Only networking resources
   ✅ modules/keyvault/    - Only Key Vault and secrets
   ❌ modules/everything/  - Mixed concerns
   ```

2. **Clear Interface**: Use descriptive variables and outputs
   ```hcl
   # Good
   variable "app_subnet_address_prefix" {
     description = "CIDR block for the application subnet"
     type        = string
   }
   
   # Less clear
   variable "subnet_cidr" {
     type = string
   }
   ```

3. **Sensible Defaults**: Provide defaults for optional variables
   ```hcl
   variable "environment" {
     description = "Environment name"
     type        = string
     default     = "dev"
   }
   ```

### Module Structure Best Practices

```
modules/
└── my-module/
    ├── main.tf          # Resources
    ├── variables.tf     # Input variables
    ├── outputs.tf       # Output values
    ├── README.md        # Documentation
    └── versions.tf      # Provider requirements (optional)
```

### Version Management

When using external modules, always pin versions:

```hcl
module "network" {
  source  = "Azure/network/azurerm"
  version = "~> 5.3.0"  # Allow patch updates, not minor
  
  # Or for more restrictive:
  version = "= 5.3.1"   # Exact version only
}
```

## Migration Strategy: From Monolith to Modules

This workshop demonstrates a common pattern - refactoring monolithic configurations:

### Before (Monolithic)
```
01-network/
├── main.tf       # All resources in one file
├── variables.tf
└── outputs.tf
```

### After (Modular)
```
01-network/
├── main.tf                  # Calls module
├── modules/
│   └── network/            # Local module
│       ├── main.tf         # Network resources
│       ├── variables.tf    # Module inputs
│       └── outputs.tf      # Module outputs
├── variables.tf            # Root variables
└── outputs.tf             # Pass-through outputs
```

## Real-World Examples

### Using Public Registry Modules

For production workloads, consider using well-established registry modules:

```hcl
# Using the official Azure Network module
module "network" {
  source  = "Azure/network/azurerm"
  version = "~> 5.0"
  
  resource_group_name = azurerm_resource_group.this.name
  vnet_name          = "vnet-prod"
  address_space      = "10.0.0.0/16"
  
  subnet_prefixes    = ["10.0.1.0/24", "10.0.2.0/24"]
  subnet_names       = ["subnet-app", "subnet-data"]
  
  tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}

# Using Azure Application Gateway module  
module "application_gateway" {
  source  = "Azure/application-gateway/azurerm"
  version = "~> 5.0"
  
  resource_group_name = azurerm_resource_group.this.name
  virtual_network_name = module.network.vnet_name
  # ... other configuration
}
```

### Combining Local and Registry Modules

A common pattern is mixing both approaches:

```hcl
# Standard components from registry
module "network" {
  source  = "Azure/network/azurerm"
  version = "~> 5.0"
  # ... standard networking
}

# Custom business logic as local modules
module "custom_security" {
  source = "./modules/security"
  
  # Your specific security requirements
  network_id = module.network.vnet_id
  # ... custom configuration
}
```

## Next Steps

1. **Practice**: Try replacing one of the local modules with a registry equivalent
2. **Explore**: Browse the [Terraform Registry](https://registry.terraform.io/browse/modules) for Azure modules
3. **Contribute**: Consider publishing your refined local modules to the registry
4. **Standards**: Establish module standards for your organization

Remember: You already have the foundation from day 3 - now you're seeing how to use modules effectively in real infrastructure projects!