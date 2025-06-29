# Variables for the Key Vault module
# These define what users can configure

variable "resource_group_name" {
  description = "Name of the resource group for Key Vault resources"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault (must be globally unique)"
  type        = string
}

variable "managed_identity_name" {
  description = "Name of the managed identity for applications"
  type        = string
}

variable "current_user_object_id" {
  description = "Object ID of the current user (for RBAC permissions)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}