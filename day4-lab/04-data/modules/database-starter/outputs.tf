output "database_server_name" {
  description = "Name of the database server"
  value       = azurerm_mssql_server.main.name
}

output "database_server_fqdn" {
  description = "Fully qualified domain name of the database server"
  value       = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "database_name" {
  description = "Name of the database"
  value       = azurerm_mssql_database.main.name
}

output "database_id" {
  description = "ID of the database"
  value       = azurerm_mssql_database.main.id
}

output "private_endpoint_ip" {
  description = "Private IP address of the database"
  value       = azurerm_private_endpoint.database.private_service_connection[0].private_ip_address
}