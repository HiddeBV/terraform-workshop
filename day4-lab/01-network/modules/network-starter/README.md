# Network Module - Build Your Own

This is a starter template for building your own network module from scratch.

## 🎯 Learning Objectives

By building this module, you will learn:
- How to design a network architecture in Terraform
- Resource dependencies and relationships
- Module input/output design patterns
- Network security best practices

## 📋 Requirements

Your module should create:
1. **Resource Group** - Container for network resources
2. **Virtual Network** - Main network with configurable address space
3. **Application Subnet** - Subnet for App Service with delegation
4. **Data Subnet** - Subnet for database with private endpoint support
5. **Network Security Group** - Security rules for application traffic
6. **NSG Association** - Link NSG to application subnet

**Total: 6 resources** (same as the complete module)

## 🏗️ Building Steps

### Step 1: Plan Your Variables
Think about what should be configurable:
- Resource names and prefixes
- Network address spaces
- Location and resource group info
- Tags for resource management

### Step 2: Design Your Outputs
Consider what other modules will need:
- Network resource IDs
- Subnet information
- Security group references

### Step 3: Build Incrementally
1. Start with resource group and VNet
2. Add subnets with proper configuration
3. Implement security group and rules
4. Create associations
5. Test each step with `terraform plan`

## 🚀 Getting Started

1. **Review the requirements** above
2. **Study the variables.tf file** to understand the expected interface
3. **Fill in main.tf** with your resource definitions
4. **Define outputs.tf** for resources other modules need
5. **Test frequently** with `terraform validate` and `terraform plan`

## 💡 Hints

<details>
<summary>Click for hints if you get stuck</summary>

### Virtual Network Hint
```hcl
resource "azurerm_virtual_network" "main" {
  # What properties does a VNet need?
  # - name
  # - address_space (as a list)
  # - location  
  # - resource_group_name
  # - tags
}
```

### Subnet Delegation Hint
```hcl
resource "azurerm_subnet" "app" {
  # App Service needs subnet delegation
  delegation {
    name = "app-service-delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
```

### NSG Rules Hint
Think about what traffic your app needs:
- HTTP (port 80)
- HTTPS (port 443)
- Should you allow or deny everything else?

</details>

## 📚 Resources

- [Azure Virtual Network Documentation](https://docs.microsoft.com/en-us/azure/virtual-network/)
- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Network Security Groups Best Practices](https://docs.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)

## ✅ Validation

When complete, your module should:
- Pass `terraform validate`
- Show exactly 6 resources in `terraform plan`
- Have all required outputs defined
- Follow Terraform naming conventions

---

**Ready to start building?** Open `main.tf` and begin with the resource group!