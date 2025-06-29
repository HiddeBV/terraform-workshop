output "sql_server_id" {
  description = "ID of the SQL Server"
  value       = azurerm_mssql_server.main.id
}

output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = azurerm_mssql_server.main.name
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "sql_database_id" {
  description = "ID of the SQL Database"
  value       = azurerm_mssql_database.main.id
}

output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = azurerm_mssql_database.main.name
}

output "resource_group_name" {
  description = "Name of the resource group containing database resources"
  value       = azurerm_resource_group.data.name
}

output "private_endpoint_id" {
  description = "ID of the SQL Server private endpoint"
  value       = azurerm_private_endpoint.sql.id
}

output "private_dns_zone_id" {
  description = "ID of the private DNS zone"
  value       = azurerm_private_dns_zone.sql.id
}

output "sql_admin_password_secret_name" {
  description = "Name of the SQL admin password secret in Key Vault"
  value       = azurerm_key_vault_secret.sql_admin_password.name
}