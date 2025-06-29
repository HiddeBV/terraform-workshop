# App Service Module - Main Resources
# Build your application hosting infrastructure here!

# TODO: Step 1 - Create App Service Plan
# Hint: This defines the compute resources for your app
# resource "azurerm_service_plan" "main" {
#   name                = var.app_service_plan_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   os_type             = "Linux"
#   sku_name            = var.app_service_plan_sku
#   tags                = var.tags
# }

# TODO: Step 2 - Create App Service with Managed Identity
# Hint: Enable system assigned identity for Key Vault access
# resource "azurerm_linux_web_app" "main" {
#   name                = var.app_service_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   service_plan_id     = azurerm_service_plan.main.id
#
#   # Enable managed identity
#   identity {
#     type         = "SystemAssigned, UserAssigned"
#     identity_ids = [var.managed_identity_id]
#   }
#
#   site_config {
#     # Your site configuration here
#   }
#
#   # Application settings with Key Vault references
#   app_settings = {
#     # Your settings here
#   }
#
#   tags = var.tags
# }

# TODO: Step 3 - Create VNet Integration
# Hint: This secures outbound traffic from your app
# resource "azurerm_app_service_virtual_network_swift_connection" "main" {
#   app_service_id = azurerm_linux_web_app.main.id
#   subnet_id      = var.app_subnet_id
# }

# 🎉 When you're done, you should have 3+ resources!
# Test with: terraform validate && terraform plan