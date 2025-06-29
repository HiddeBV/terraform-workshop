# Database Module - Main Resources
# Build your secure database infrastructure here!

# TODO: Step 1 - Create Azure SQL Server
# Hint: This is the logical server that hosts your databases
# resource "azurerm_mssql_server" "main" {
#   name                         = var.database_server_name
#   resource_group_name          = var.resource_group_name
#   location                     = var.location
#   version                      = "12.0"
#   administrator_login          = var.database_admin_username
#   administrator_login_password = var.database_admin_password
#
#   # Security settings
#   public_network_access_enabled = false  # Force private access only
#   
#   tags = var.tags
# }

# TODO: Step 2 - Create Azure SQL Database
# Hint: This is the actual database within the server
# resource "azurerm_mssql_database" "main" {
#   name           = var.database_name
#   server_id      = azurerm_mssql_server.main.id
#   collation      = "SQL_Latin1_General_CP1_CI_AS"
#   license_type   = "LicenseIncluded"
#   max_size_gb    = 2
#   sku_name       = "Basic"
#   zone_redundant = false
#
#   tags = var.tags
# }

# TODO: Step 3 - Create Private Endpoint
# Hint: This allows secure access from your VNet
# resource "azurerm_private_endpoint" "database" {
#   name                = "${var.database_server_name}-pe"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   subnet_id           = var.data_subnet_id
#
#   private_service_connection {
#     name                           = "${var.database_server_name}-pe-connection"
#     private_connection_resource_id = azurerm_mssql_server.main.id
#     subresource_names             = ["sqlServer"]
#     is_manual_connection          = false
#   }
#
#   tags = var.tags
# }

# TODO: Step 4 - Create Private DNS Zone
# Hint: This resolves the private endpoint to internal IP addresses
# resource "azurerm_private_dns_zone" "database" {
#   name                = "privatelink.database.windows.net"
#   resource_group_name = var.resource_group_name
#   tags                = var.tags
# }

# TODO: Step 5 - Link DNS Zone to VNet
# Hint: This enables DNS resolution within your virtual network
# resource "azurerm_private_dns_zone_virtual_network_link" "database" {
#   name                  = "database-dns-link"
#   resource_group_name   = var.resource_group_name
#   private_dns_zone_name = azurerm_private_dns_zone.database.name
#   virtual_network_id    = var.vnet_id
#   registration_enabled  = false
#   tags                  = var.tags
# }

# TODO: Step 6 - Create DNS A Record for Private Endpoint
# Hint: This maps the database FQDN to the private IP
# resource "azurerm_private_dns_a_record" "database" {
#   name                = azurerm_mssql_server.main.name
#   zone_name           = azurerm_private_dns_zone.database.name
#   resource_group_name = var.resource_group_name
#   ttl                 = 300
#   records             = [azurerm_private_endpoint.database.private_service_connection.0.private_ip_address]
#   tags                = var.tags
# }

# 🎉 When you're done, you should have 6 resources!
# Test with: terraform validate && terraform plan