output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = module.database.sql_server_name
}

output "sql_server_id" {
  description = "ID of the SQL Server"
  value       = module.database.sql_server_id
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = module.database.sql_server_fqdn
}

output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = module.database.sql_database_name
}

output "sql_database_id" {
  description = "ID of the SQL Database"
  value       = module.database.sql_database_id
}

output "private_endpoint_id" {
  description = "ID of the private endpoint"
  value       = module.database.private_endpoint_id
}

output "private_dns_zone_id" {
  description = "ID of the private DNS zone"
  value       = module.database.private_dns_zone_id
}

output "resource_group_name" {
  description = "Name of the resource group containing database resources"
  value       = module.database.resource_group_name
}

output "connection_string" {
  description = "Database connection string for applications"
  value       = "Server=tcp:${module.database.sql_server_fqdn},1433;Database=${module.database.sql_database_name};Authentication=Active Directory Default;Trusted_Connection=False;Encrypt=True;Connection Timeout=30;"
  sensitive   = true
}