variable "resource_group_name" {
  description = "Name of the resource group for database resources"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
}

variable "sql_admin_username" {
  description = "SQL Server administrator username"
  type        = string
}

variable "azuread_admin_login" {
  description = "Azure AD administrator login name"
  type        = string
}

variable "azuread_admin_object_id" {
  description = "Azure AD administrator object ID"
  type        = string
}

variable "azuread_admin_tenant_id" {
  description = "Azure AD administrator tenant ID"
  type        = string
}

variable "data_subnet_id" {
  description = "ID of the data subnet for private endpoint"
  type        = string
}

variable "vnet_id" {
  description = "ID of the virtual network"
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Key Vault for storing secrets"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}