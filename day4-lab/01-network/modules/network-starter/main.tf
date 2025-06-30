# Network Module - Main Resources
# Build your network infrastructure here!

# TODO: Step 1 - Create Resource Group
# Hint: Resource groups are containers for related resources
# resource "azurerm_resource_group" "network" {
#   name     = "${var.resource_group_name}-${formatdate("YYYYMMDD", timestamp())}"
#   location = var.location
#   tags     = var.tags
# }

# TODO: Step 2 - Create Virtual Network
# Hint: VNets need a name, address space, location, and resource group
# resource "azurerm_virtual_network" "main" {
#   # Your implementation here
# }

# TODO: Step 3 - Create Application Subnet
# Hint: This subnet needs delegation for App Service
# resource "azurerm_subnet" "app" {
#   # Your implementation here
#   
#   # Don't forget the delegation block for App Service:
#   # delegation {
#   #   name = "app-service-delegation"
#   #   service_delegation {
#   #     name    = "Microsoft.Web/serverFarms"
#   #     actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
#   #   }
#   # }
# }

# TODO: Step 4 - Create Data Subnet
# Hint: This subnet needs private endpoint support
# resource "azurerm_subnet" "data" {
#   # Your implementation here
#   
#   # Enable private endpoint support:
#   # private_endpoint_network_policies = "Disabled"
# }

# TODO: Step 5 - Create Network Security Group
# Hint: NSGs control network traffic with security rules
# resource "azurerm_network_security_group" "app" {
#   # Your implementation here
#   
#   # Think about what rules you need:
#   # - Allow HTTP (port 80)
#   # - Allow HTTPS (port 443)  
#   # - What about other traffic?
# }

# TODO: Step 6 - Associate NSG with App Subnet
# Hint: This links the security group to the subnet
# resource "azurerm_subnet_network_security_group_association" "app" {
#   # Your implementation here
# }

# 🎉 When you're done, you should have 6 resources total!
# Test with: terraform validate && terraform plan