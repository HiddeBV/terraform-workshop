# Terraform Associate Study Guide

## 📚 Key Concepts by Domain

### Domain 1: Understand Infrastructure as Code (IaC) concepts (15%)

#### Core Concepts
- **Infrastructure as Code**: Managing infrastructure through machine-readable definition files
- **Benefits**: Version control, reproducibility, consistency, collaboration, documentation
- **Configuration Drift**: When actual infrastructure differs from code
- **Infrastructure Drift**: Changes made outside of IaC tools
- **Immutable Infrastructure**: Replace rather than modify resources

#### Key Terms
- **Declarative**: Describe desired end state
- **Imperative**: Describe steps to achieve state
- **Idempotent**: Same operation can be applied multiple times safely

---

### Domain 2: Understand Terraform's purpose (20%)

#### Terraform Overview
- **Type**: Infrastructure provisioning tool
- **Company**: HashiCorp
- **Language**: HCL (HashiCorp Configuration Language)
- **Approach**: Declarative, cloud-agnostic, agentless

#### Key Components
- **Providers**: Plugins for different platforms (AWS, Azure, GCP, etc.)
- **Registry**: Repository of providers and modules
- **Terraform Cloud**: HashiCorp's managed service
- **File Extensions**: .tf, .tf.json, .tfvars

#### Capabilities
- Multi-cloud provisioning
- API-based resource management
- State management
- Plan and apply workflow

---

### Domain 3: Understand Terraform basics (25%)

#### Core Workflow
```bash
terraform init    # Initialize working directory
terraform plan    # Create execution plan
terraform apply   # Execute the plan
terraform destroy # Remove resources
```

#### Configuration Elements
- **Resources**: Infrastructure components (`resource "type" "name" {}`)
- **Data Sources**: Read-only external information (`data "type" "name" {}`)
- **Variables**: Input parameters (`variable "name" {}`)
- **Outputs**: Return values (`output "name" {}`)
- **Modules**: Reusable resource containers

#### State Management
- **Purpose**: Track managed resources
- **Default Location**: `terraform.tfstate` (local file)
- **Importance**: Critical for Terraform operation
- **State Loss**: Terraform loses track of resources

#### Syntax
- **Variable Reference**: `var.variable_name`
- **Resource Reference**: `resource_type.resource_name.attribute`
- **Interpolation**: `${expression}` (legacy) or direct expressions
- **Dependencies**: `depends_on` for explicit dependencies

---

### Domain 4: Use the Terraform CLI (30%)

#### Essential Commands

##### Initialization & Planning
```bash
terraform init              # Initialize directory
terraform init -upgrade     # Upgrade providers
terraform plan              # Show execution plan
terraform plan -out=file    # Save plan to file
```

##### Applying Changes
```bash
terraform apply                    # Apply changes
terraform apply -auto-approve     # Skip confirmation
terraform apply -target=resource  # Target specific resource
terraform apply plan.tfplan       # Apply saved plan
```

##### State Management
```bash
terraform state list              # List all resources
terraform state show resource     # Show resource details
terraform state mv old new        # Move/rename resource
terraform state rm resource       # Remove from state
terraform import resource id     # Import existing resource
```

##### Utilities
```bash
terraform validate          # Validate configuration
terraform fmt              # Format code
terraform graph            # Create dependency graph
terraform show             # Show state or plan
terraform refresh          # Update state from real world
```

#### Command Flags
- **Variables**: `-var="name=value"`, `-var-file=filename`
- **State**: `-state=path`
- **Targeting**: `-target=resource`
- **Output**: `-out=filename`
- **Automation**: `-auto-approve`
- **Verbosity**: `-v` for verbose output

---

### Domain 5: Interact with Terraform modules (10%)

#### Module Basics
- **Definition**: Container for multiple resources used together
- **Benefits**: Reusability, organization, abstraction
- **Required Argument**: `source` (where module is located)

#### Module Sources
```hcl
# Local filesystem
module "vpc" {
  source = "./modules/vpc"
}

# Terraform Registry
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"
}

# Git repository
module "vpc" {
  source = "git::https://github.com/user/repo.git"
}
```

#### Module Structure
```
module/
├── main.tf          # Primary resources
├── variables.tf     # Input variables
├── outputs.tf       # Return values
└── README.md        # Documentation
```

#### Using Modules
```hcl
module "example" {
  source = "./modules/example"
  
  # Pass variables to module
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id
}

# Reference module outputs
resource "aws_instance" "app" {
  # ... other configuration
  security_groups = [module.example.security_group_id]
}
```

#### Best Practices
- Use versioned modules from registry
- Pin module versions in production
- Run `terraform init` after adding modules
- Document module inputs and outputs

---

## 🎯 Common Exam Topics

### Terraform Workflow
1. Write configuration
2. `terraform init`
3. `terraform plan`
4. `terraform apply`
5. Manage and update resources
6. `terraform destroy` when done

### State File Management
- Never edit state files manually
- Store state remotely for teams
- Use state locking to prevent conflicts
- Back up state files regularly

### Best Practices
- Use consistent naming conventions
- Organize code with modules
- Use variables for reusability
- Output important values
- Pin provider versions
- Use remote state for teams

### Security Considerations
- Don't commit sensitive data
- Use environment variables for secrets
- Implement least privilege access
- Enable state file encryption
- Use separate environments

---

## 📖 Study Resources

### Official Documentation
- [Terraform Documentation](https://terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io)
- [Terraform Associate Exam Guide](https://developer.hashicorp.com/terraform/tutorials/certification)

### Hands-on Practice
- Complete all workshop sprints (00-04)
- Practice with multiple cloud providers
- Build modules from scratch
- Import existing resources
- Experiment with state management

### Key Areas to Master
- CLI command syntax and options
- State file concepts and management
- Module creation and usage
- Provider configuration
- Variable and output usage
- Terraform workflow and best practices

---

## ⚡ Quick Reference

### File Extensions
- `.tf` - Terraform configuration
- `.tfvars` - Variable values
- `.tfstate` - State file
- `.tf.json` - JSON configuration

### Common Resource Types (AWS Examples)
- `aws_instance` - EC2 instance
- `aws_vpc` - Virtual Private Cloud
- `aws_subnet` - Subnet
- `aws_security_group` - Security group
- `aws_s3_bucket` - S3 bucket

### Variable Types
- `string` - Text value
- `number` - Numeric value  
- `bool` - True/false
- `list` - Ordered collection
- `map` - Key-value pairs
- `object` - Complex structure

### Built-in Functions
- `length()` - Get length of list/map
- `element()` - Get element at index
- `lookup()` - Look up value in map
- `file()` - Read file contents
- `join()` - Join list elements
- `split()` - Split string into list