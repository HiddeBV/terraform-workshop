variable "network_resource_group_name" {
  description = "Name of the resource group containing network resources (from Sprint 2)"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network (from Sprint 2)"
  type        = string
  default     = "vnet-workshop"
}

variable "data_subnet_name" {
  description = "Name of the data subnet (from Sprint 2)"
  type        = string
  default     = "snet-data"
}

variable "nsg_name" {
  description = "Name of the Network Security Group (from Sprint 2)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group for database resources"
  type        = string
  default     = "rg-terraform-data"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "West Europe"
}

variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
  default     = "sql-workshop-server"
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
  default     = "workshop-db"
}

variable "sql_admin_username" {
  description = "SQL Server administrator username"
  type        = string
  default     = "workshopadmin"
}

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
  default     = "pe-sql-workshop"
}

variable "azuread_admin_login" {
  description = "Azure AD administrator login name"
  type        = string
  default     = "workshop-admin"
}

variable "azuread_admin_object_id" {
  description = "Azure AD administrator object ID"
  type        = string
  default     = ""
}

variable "azuread_admin_tenant_id" {
  description = "Azure AD administrator tenant ID"
  type        = string
  default     = ""
}

variable "keyvault_resource_group_name" {
  description = "Name of the resource group containing Key Vault resources (from Sprint 3)"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault (from Sprint 3)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "workshop"
    Sprint      = "05-data"
    ManagedBy   = "terraform"
  }
}