# Build Your Own Modules Guide

This guide teaches you how to build Terraform modules from scratch, giving you hands-on experience with module development before exploring pre-built alternatives.

## 🎯 Learning Objectives

By the end of this guide, you will:
- Understand how to design and structure Terraform modules
- Build modules incrementally from basic to advanced patterns
- Learn when to build custom vs. use existing modules
- Gain confidence in module development and maintenance

## 🛤️ Three Learning Pathways

This workshop offers three ways to learn about Terraform modules:

### 1. 🔨 Build Your Own (Recommended for Learning)
**Best for**: Understanding module internals, learning best practices, gaining deep knowledge
- Start with empty starter templates
- Build resources step-by-step
- Understand every line of code
- **Time**: Longer, but more educational

### 2. 🏭 Use Local Modules (Provided)
**Best for**: Focus on module usage patterns, faster completion
- Use complete, working local modules
- Focus on module composition and configuration
- Learn module interfaces and outputs
- **Time**: Faster implementation

### 3. 🌐 Use Registry Modules (Production-Ready)
**Best for**: Production scenarios, battle-tested solutions
- Leverage community-maintained modules
- Learn production patterns and best practices
- Focus on integration and configuration
- **Time**: Fastest, but less learning about internals

## 🚀 Getting Started: Build Your Own

### Step 1: Understanding Module Structure

Every Terraform module should follow this structure:
```
modules/my-module/
├── main.tf          # Primary resources
├── variables.tf     # Input variables
├── outputs.tf       # Output values
├── README.md        # Documentation
└── versions.tf      # Provider requirements (optional)
```

### Step 2: Design Principles

Before writing code, consider:

1. **Single Responsibility**: What specific problem does your module solve?
2. **Reusability**: Can this module be used in multiple environments?
3. **Configurability**: What should be configurable vs. opinionated defaults?
4. **Interface Design**: What inputs and outputs make sense?

### Step 3: Start Small, Build Up

#### Phase 1: Core Resources
Start with the minimum viable module:
- Define basic resources
- Add essential variables
- Create primary outputs

#### Phase 2: Add Configuration
Enhance with:
- More configuration options
- Conditional logic
- Default values

#### Phase 3: Add Advanced Features
Polish with:
- Validation rules
- Complex data structures
- Error handling

## 📚 Module Building Exercises

### Exercise 1: Network Module (Sprint 2)

**Goal**: Build a network module from scratch

#### What You'll Build:
- Virtual Network with configurable address space
- Application subnet with delegation
- Data subnet with private endpoint support
- Network Security Group with custom rules
- Subnet associations

#### Learning Focus:
- Resource dependencies
- Variable design
- Output planning
- Security considerations

#### Starter Template Location:
`01-network/modules/network-starter/`

### Exercise 2: Key Vault Module (Sprint 3)

**Goal**: Build a secure Key Vault module

#### What You'll Build:
- Key Vault with RBAC authorization
- Managed identity for applications
- Role assignments with least privilege
- Secret management patterns

#### Learning Focus:
- Security best practices
- RBAC vs access policies
- Identity management
- Secret lifecycle

#### Starter Template Location:
`02-keyvault/modules/keyvault-starter/`

### Exercise 3: App Service Module (Sprint 4)

**Goal**: Build an application hosting module

#### What You'll Build:
- App Service Plan with proper sizing
- App Service with managed identity
- VNet integration for security
- Application settings management

#### Learning Focus:
- Application architecture
- Identity integration
- Network security
- Configuration management

#### Starter Template Location:
`03-app/modules/app-service-starter/`

### Exercise 4: Database Module (Sprint 5)

**Goal**: Build a secure database module

#### What You'll Build:
- Azure SQL Database with security features
- Private endpoint for network isolation
- Connection string management
- Database security settings

#### Learning Focus:
- Data security patterns
- Private networking
- Secret management
- High availability considerations

#### Starter Template Location:
`04-data/modules/database-starter/`

## 🔄 Switching Between Approaches

Each lab directory provides easy switching:

```bash
# Use your custom-built module
module "network" {
  source = "./modules/network-starter"
  # ... your configuration
}

# Use provided complete module
module "network" {
  source = "./modules/network"
  # ... your configuration
}

# Use registry module (see REGISTRY-MODULE-EXAMPLES.md)
module "network" {
  source  = "Azure/network/azurerm"
  version = "~> 5.0"
  # ... registry module configuration
}
```

## 🎓 Best Practices for Module Development

### 1. Start with Requirements
- List all resources needed
- Define input parameters
- Plan output values
- Consider security requirements

### 2. Use Consistent Naming
```hcl
# Good
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Avoid
variable "rg" {
  type = string
}
```

### 3. Provide Good Defaults
```hcl
variable "app_service_plan_sku" {
  description = "SKU for the App Service Plan"
  type        = string
  default     = "P1v2"
}
```

### 4. Validate Inputs
```hcl
variable "location" {
  description = "Azure region for resources"
  type        = string
  
  validation {
    condition     = contains(["eastus", "westus2", "westeurope"], var.location)
    error_message = "Location must be one of: eastus, westus2, westeurope."
  }
}
```

### 5. Document Everything
```hcl
variable "vnet_address_space" {
  description = "Address space for the virtual network (CIDR notation)"
  type        = string
  default     = "10.0.0.0/16"
  
  validation {
    condition     = can(cidrhost(var.vnet_address_space, 0))
    error_message = "VNet address space must be a valid CIDR block."
  }
}
```

## 🧪 Testing Your Modules

### 1. Validation Tests
```bash
terraform validate
terraform fmt -check
```

### 2. Plan Tests
```bash
terraform plan -out=plan.out
terraform show -json plan.out | jq '.resource_changes | length'
```

### 3. Apply Tests
```bash
terraform apply plan.out
terraform destroy
```

## 🚀 When You're Ready for More

After building your own modules:

1. **Compare with Registry Modules**: See how your approach differs from community modules
2. **Refactor for Reusability**: Make your modules more generic and configurable
3. **Add Advanced Features**: Implement complex scenarios and edge cases
4. **Consider Publishing**: Share your modules with the community

## 💡 Pro Tips

- **Start Simple**: Build the minimum viable module first
- **Iterate Quickly**: Test frequently with `terraform plan`
- **Learn from Examples**: Study the provided complete modules for ideas
- **Ask Questions**: Use the community and documentation extensively
- **Document Decisions**: Write README files explaining your choices

---

**Ready to build?** Choose a sprint and start with the `-starter` module template. Remember: the goal is learning, not perfection!