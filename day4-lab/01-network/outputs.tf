output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "resource_group_name" {
  description = "Name of the resource group containing network resources"
  value       = azurerm_resource_group.network.name
}

output "app_subnet_id" {
  description = "ID of the application subnet"
  value       = azurerm_subnet.app.id
}

output "app_subnet_name" {
  description = "Name of the application subnet"
  value       = azurerm_subnet.app.name
}

output "data_subnet_id" {
  description = "ID of the data subnet"
  value       = azurerm_subnet.data.id
}

output "data_subnet_name" {
  description = "Name of the data subnet"
  value       = azurerm_subnet.data.name
}

output "nsg_id" {
  description = "ID of the network security group"
  value       = azurerm_network_security_group.app.id
}

output "nsg_name" {
  description = "Name of the network security group"
  value       = azurerm_network_security_group.app.name
}