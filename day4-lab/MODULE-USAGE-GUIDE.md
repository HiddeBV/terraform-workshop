# Module Usage Guide

This guide demonstrates different ways to use Terraform modules, **with emphasis on building your own modules first** before exploring pre-built alternatives.

## 🛤️ Three Learning Pathways

### 🔨 1. Build Your Own Modules (Recommended for Learning)

**Perfect for**: Understanding module internals, mastering Terraform concepts, building confidence

Local modules that you build from scratch using starter templates:
```hcl
module "network" {
  source = "./modules/network-starter"  # Your custom implementation
  
  resource_group_name = var.resource_group_name
  location           = var.location
  # ... your variables
}
```

**Benefits:**
- ✅ Deep understanding of every resource and configuration
- ✅ Learn Terraform syntax and best practices hands-on
- ✅ Confidence to modify and extend functionality
- ✅ Understanding of resource dependencies and relationships
- ✅ No external dependencies while learning

**Use when:**
- You're learning Terraform and want to understand how things work
- Building project-specific infrastructure with custom requirements
- Need to understand every component for troubleshooting
- Want to develop strong Terraform skills

**Time investment:** Higher, but much more educational

### 🏭 2. Local Modules (Pre-built for this Workshop)

**Perfect for**: Focusing on module usage patterns, faster workshop completion

Local modules that are complete and ready to use:
```hcl
module "network" {
  source = "./modules/network"  # Complete implementation provided
  
  resource_group_name = var.resource_group_name
  location           = var.location
  # ... other variables
}
```

**Benefits:**
- ✅ Fast implementation and completion
- ✅ Focus on module composition and integration patterns
- ✅ Learn module interfaces and output usage
- ✅ Version controlled with your project

**Use when:**
- You want to focus on module usage rather than development
- Time is limited but you want to complete the workshop
- You're already comfortable with Terraform syntax
- Building production systems with proven patterns

### 🌐 3. Terraform Registry Modules

**Perfect for**: Production scenarios, battle-tested solutions, following community best practices

Public modules from the official Terraform Registry:
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
- ✅ Semantic versioning and stability
- ✅ Comprehensive documentation
- ✅ Industry best practices built-in
- ✅ Regular updates and security patches

**Use when:**
- Building production systems
- Want to follow Azure/AWS best practices
- Need comprehensive, feature-rich modules
- Prefer community-supported code

## 🎯 Recommended Learning Path

1. **Start with Build Your Own** (Path 1) - Learn the fundamentals
2. **Compare with Pre-built** (Path 2) - See different implementation approaches  
3. **Explore Registry Modules** (Path 3) - Understand production patterns

This progression gives you:
- Deep understanding → Fast implementation → Production readiness

## 🔄 Easy Switching Between Approaches

Each lab provides all three options. Simply change the source:

```hcl
# Build your own (recommended for learning)
module "network" {
  source = "./modules/network-starter"
  # ... your configuration
}

# Use complete local module (faster completion)
module "network" {
  source = "./modules/network"
  # ... same configuration
}

# Use registry module (production patterns)
module "network" {
  source  = "Azure/network/azurerm"
  version = "~> 5.0"
  # ... registry module configuration (see REGISTRY-MODULE-EXAMPLES.md)
}
```

## 📚 Module Development Guide

### Build Your Own Modules

Each lab includes:
- **Starter templates** in `modules/[name]-starter/` directories
- **Step-by-step guides** in module README files
- **Building hints** and tips for common challenges
- **Validation steps** to ensure correctness

See [BUILD-YOUR-OWN-GUIDE.md](BUILD-YOUR-OWN-GUIDE.md) for comprehensive building instructions.

## Additional Module Sources

### Private Registry Modules

```hcl
module "custom_network" {
  source  = "app.terraform.io/your-org/network/azurerm"
  version = "~> 1.0"
  
  # Your custom module interface
}
```

### Git Repository Modules

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