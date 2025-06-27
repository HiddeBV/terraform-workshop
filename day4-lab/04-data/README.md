# Sprint 5 - SQL Database & Private Endpoint

This module creates Azure SQL Database with Private Endpoint for secure network connectivity.

## Overview

Creates:
- Azure SQL Server
- Azure SQL Database
- Private Endpoint for SQL Server
- Private DNS Zone for private link
- Network integration for secure connectivity

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
<!-- END_TF_DOCS -->