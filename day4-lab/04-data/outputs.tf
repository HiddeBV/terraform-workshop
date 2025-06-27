output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = azurerm_mssql_server.main.name
}

output "sql_server_id" {
  description = "ID of the SQL Server"
  value       = azurerm_mssql_server.main.id
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = azurerm_mssql_database.main.name
}

output "sql_database_id" {
  description = "ID of the SQL Database"
  value       = azurerm_mssql_database.main.id
}

output "private_endpoint_id" {
  description = "ID of the private endpoint"
  value       = azurerm_private_endpoint.sql.id
}

output "private_endpoint_ip" {
  description = "Private IP address of the SQL Server"
  value       = azurerm_private_endpoint.sql.private_service_connection[0].private_ip_address
}

output "private_dns_zone_name" {
  description = "Name of the private DNS zone"
  value       = azurerm_private_dns_zone.sql.name
}

output "resource_group_name" {
  description = "Name of the resource group containing database resources"
  value       = azurerm_resource_group.data.name
}

output "sql_admin_password" {
  description = "SQL Server administrator password"
  value       = random_password.sql_admin.result
  sensitive   = true
}

output "connection_string" {
  description = "Database connection string for applications"
  value       = "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name},1433;Database=${azurerm_mssql_database.main.name};User ID=${var.sql_admin_username};Password=${random_password.sql_admin.result};Trusted_Connection=False;Encrypt=True;Connection Timeout=30;"
  sensitive   = true
}