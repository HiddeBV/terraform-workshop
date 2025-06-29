# Sprint 5 - SQL Database & Private Endpoint

This lab teaches secure database architecture using **modular Terraform patterns**. Choose your learning path below!

## 🛤️ Choose Your Learning Path

### 🔨 Path 1: Build Your Own Module (Recommended)
**Best for**: Learning database security, private networking, DNS integration
- Start with starter templates in `modules/database-starter/`  
- Build secure database with private endpoint step-by-step
- Learn private networking and DNS patterns
- **Time**: 45-60 minutes | **Learning**: Maximum

### 🏭 Path 2: Use Complete Local Module
**Best for**: Focus on database integration and private connectivity
- Use ready-made module in `modules/database/`
- Focus on private endpoint configuration
- Learn database security patterns
- **Time**: 20-35 minutes | **Learning**: Moderate

### 🌐 Path 3: Use Registry Module
**Best for**: Production database patterns, enterprise security
- Follow examples in [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md)
- Learn enterprise database configurations
- See production security patterns
- **Time**: 25-35 minutes | **Learning**: Different focus

> 💡 **Security Focus**: All paths create the same secure database accessible only via private endpoint!

## 📚 What You'll Create

All paths create the same secure database infrastructure:
- Azure SQL Server with security configurations
- Azure SQL Database with appropriate sizing
- Private Endpoint for secure network access
- Private DNS Zone for internal name resolution
- Network integration ensuring database isolation

## 🚀 Getting Started

### For Path 1: Build Your Own Module

1. **Start with the starter template**:
   ```bash
   cd 04-data/modules/database-starter/
   cat README.md  # Read the database building guide
   ```

2. **Configure main.tf to use your module**:
   ```hcl
   module "database" {
     source = "./modules/database-starter"  # 👈 Point to your module
     
     # ... same variables as other paths
   }
   ```

3. **Build incrementally with security focus**:
   - Fill in `modules/database-starter/main.tf`
   - Focus on private networking and DNS
   - Test with `terraform validate` and `terraform plan`

### For Path 2: Use Complete Module

1. **Use the provided module** (already configured):
   ```hcl
   module "database" {
     source = "./modules/database"  # 👈 Complete implementation
     
     # ... your configuration
   }
   ```

2. **Focus on private endpoint integration**

### For Path 3: Use Registry Module

1. **Follow the registry examples**:
   - See [REGISTRY-MODULE-EXAMPLES.md](../REGISTRY-MODULE-EXAMPLES.md)
   - Replace the local module source with registry source

## Prerequisites

- Sprint 1 (00-backend) completed
- Sprint 2 (01-network) completed
- Sprint 3 (02-keyvault) completed
- Sprint 4 (03-app) completed
- Backend configuration set up

## Usage

1. Configure backend using outputs from Sprint 1
2. Initialize and apply:
```bash
terraform init
terraform plan
terraform apply
```

3. Test private connectivity:
```bash
nslookup <db-fqdn>  # Should resolve to 10.x address
```

## Definition of Done ✅

- Public access to port 1433 blocked
- `nslookup <db-fqdn>` resolves to 10.x address
- Tests & docs pass

## Resources Created

- `azurerm_mssql_server.main` - SQL Server
- `azurerm_mssql_database.main` - SQL Database
- `azurerm_private_endpoint.sql` - Private Endpoint for SQL Server
- `azurerm_private_dns_zone.sql` - Private DNS Zone
- `azurerm_private_dns_zone_virtual_network_link.sql` - DNS Zone VNet link

## Outputs

- `sql_server_name` - Name of the SQL Server
- `sql_database_name` - Name of the SQL Database
- `sql_server_fqdn` - FQDN of the SQL Server
- `private_endpoint_ip` - Private IP address of the SQL Server

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.0 |

## Resources

| random_string | resource |
| random_password | resource |
| azurerm_resource_group | resource |
| azurerm_mssql_server | resource |
| azurerm_mssql_database | resource |
| azurerm_private_dns_zone | resource |
| azurerm_private_dns_zone_virtual_network_link | resource |
| azurerm_private_endpoint | resource |
| azurerm_network_security_rule | resource |

## Inputs

| <a name="input_network_resource_group_name"></a> [network_resource_group_name](#input\_network_resource_group_name) | n/a | no |
| <a name="input_vnet_name"></a> [vnet_name](#input\_vnet_name) | n/a | no |
| <a name="input_data_subnet_name"></a> [data_subnet_name](#input\_data_subnet_name) | n/a | no |
| <a name="input_nsg_name"></a> [nsg_name](#input\_nsg_name) | n/a | no |
| <a name="input_resource_group_name"></a> [resource_group_name](#input\_resource_group_name) | n/a | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | no |
| <a name="input_sql_server_name"></a> [sql_server_name](#input\_sql_server_name) | n/a | no |
| <a name="input_sql_database_name"></a> [sql_database_name](#input\_sql_database_name) | n/a | no |
| <a name="input_sql_admin_username"></a> [sql_admin_username](#input\_sql_admin_username) | n/a | no |
| <a name="input_private_endpoint_name"></a> [private_endpoint_name](#input\_private_endpoint_name) | n/a | no |
| <a name="input_azuread_admin_login"></a> [azuread_admin_login](#input\_azuread_admin_login) | n/a | no |
| <a name="input_azuread_admin_object_id"></a> [azuread_admin_object_id](#input\_azuread_admin_object_id) | n/a | no |
| <a name="input_azuread_admin_tenant_id"></a> [azuread_admin_tenant_id](#input\_azuread_admin_tenant_id) | n/a | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | no |

## Outputs

| sql_server_name | n/a |
| sql_server_id | n/a |
| sql_server_fqdn | n/a |
| sql_database_name | n/a |
| sql_database_id | n/a |
| private_endpoint_id | n/a |
| private_endpoint_ip | n/a |
| private_dns_zone_name | n/a |
| resource_group_name | n/a |
| sql_admin_password | n/a |
| connection_string | n/a |

<!-- END_TF_DOCS -->
