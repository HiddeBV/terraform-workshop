# Key Vault Module - Build Your Own

This is a starter template for building your own Key Vault module from scratch with security best practices.

## 🎯 Learning Objectives

By building this module, you will learn:
- Azure Key Vault security patterns and RBAC
- Managed identity concepts and implementation
- Secret management and least privilege access
- Security best practices for cloud infrastructure

## 📋 Requirements

Your module should create:
1. **Random String** - For unique naming
2. **Key Vault** - Secure secrets storage with RBAC enabled
3. **Managed Identity** - For application access to secrets
4. **Role Assignment (Current User)** - Key Vault Secrets Officer role
5. **Role Assignment (Managed Identity)** - Key Vault Secrets User role
6. **Database Connection Secret** - Connection string for the database

**Total: 6 resources**

## 🔐 Security Model

This module implements **RBAC (Role-Based Access Control)** for enhanced security:

- **Current User/Service Principal**: `Key Vault Secrets Officer` role
  - Can create, read, update, and delete secrets
  - Cannot modify access control or vault settings
- **Managed Identity**: `Key Vault Secrets User` role  
  - Can only read secrets (least privilege principle)
  - Perfect for application access to secrets

## 🏗️ Building Steps

### Step 1: Plan Your Security Model
- Who needs access to what?
- What level of permissions do they need?
- How will applications authenticate securely?

### Step 2: Unique Naming Strategy
- Key Vault names must be globally unique
- Use random strings for uniqueness
- Consider naming conventions

### Step 3: Build Incrementally
1. Random string for unique naming
2. Key Vault with RBAC enabled
3. Managed identity for applications
4. Role assignments with appropriate permissions
5. Sample secrets for testing
6. Test each step with `terraform plan`

## 🚀 Getting Started

1. **Review the security model** above
2. **Study the variables.tf file** to understand the expected interface
3. **Fill in main.tf** with your resource definitions
4. **Define outputs.tf** for resources other modules need
5. **Test frequently** with `terraform validate` and `terraform plan`

## 💡 Hints

<details>
<summary>Click for hints if you get stuck</summary>

### Random String Hint
```hcl
resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}
```

### Key Vault Hint
```hcl
resource "azurerm_key_vault" "main" {
  # Required properties:
  # - name (must be globally unique)
  # - location
  # - resource_group_name
  # - sku_name
  # - tenant_id
  
  # Important: Enable RBAC authorization
  enable_rbac_authorization = true
  
  # Disable access policies (we're using RBAC)
  enabled_for_deployment          = false
  enabled_for_disk_encryption     = false
  enabled_for_template_deployment = false
}
```

### Managed Identity Hint
```hcl
resource "azurerm_user_assigned_identity" "app" {
  # Managed identities provide secure authentication
  # without storing credentials in code
}
```

### Role Assignment Hint
```hcl
resource "azurerm_role_assignment" "current_user" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.current_user_object_id
}
```

### Secret Hint
```hcl
resource "azurerm_key_vault_secret" "database_connection_string" {
  # Secrets should be stored securely and accessed via RBAC
  # Consider what secrets your application needs
}
```

</details>

## 📚 Resources

- [Azure Key Vault Documentation](https://docs.microsoft.com/en-us/azure/key-vault/)
- [Key Vault RBAC Guide](https://docs.microsoft.com/en-us/azure/key-vault/general/rbac-guide)
- [Managed Identity Documentation](https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/)

## ✅ Validation

When complete, your module should:
- Pass `terraform validate`
- Show exactly 6 resources in `terraform plan`
- Have proper RBAC configuration (no access policies)
- Include managed identity for secure app access
- Have all required outputs defined

---

**Ready to start building?** Open `main.tf` and begin with the random string for unique naming!