variable "network_resource_group_name" {
  description = "Name of the resource group containing network resources (from Sprint 2)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group for Key Vault resources"
  type        = string
  default     = "rg-terraform-keyvault"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "West Europe"
}

variable "key_vault_name" {
  description = "Name of the Key Vault (will be suffixed with random string)"
  type        = string
  default     = "kv-workshop"

  validation {
    condition     = length(var.key_vault_name) <= 16 && can(regex("^[a-zA-Z][a-zA-Z0-9-]*$", var.key_vault_name))
    error_message = "Key Vault name must be 16 characters or less, start with a letter, and contain only letters, numbers, and hyphens."
  }
}

variable "managed_identity_name" {
  description = "Name of the managed identity"
  type        = string
  default     = "id-workshop-app"
}

variable "database_server_name" {
  description = "Name of the database server (for connection string)"
  type        = string
  default     = "sql-workshop-server"
}

variable "database_name" {
  description = "Name of the database"
  type        = string
  default     = "workshop-db"
}

variable "database_admin_username" {
  description = "Database administrator username"
  type        = string
  default     = "workshopadmin"
  sensitive   = true
}

variable "database_admin_password" {
  description = "Database administrator password"
  type        = string
  default     = "Workshop123!"
  sensitive   = true

  validation {
    condition     = length(var.database_admin_password) >= 8
    error_message = "Database password must be at least 8 characters long."
  }
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "workshop"
    Sprint      = "03-keyvault"
    ManagedBy   = "terraform"
  }
}