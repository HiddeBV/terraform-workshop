variable "resource_group_name" {
  description = "Name of the resource group for App Service resources"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "app_service_plan_sku" {
  description = "SKU of the App Service Plan"
  type        = string
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
}

variable "managed_identity_id" {
  description = "ID of the managed identity"
  type        = string
}

variable "managed_identity_client_id" {
  description = "Client ID of the managed identity"
  type        = string
}

variable "key_vault_uri" {
  description = "URI of the Key Vault"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "app_subnet_id" {
  description = "ID of the application subnet"
  type        = string
}

variable "source_control_repo_url" {
  description = "Source control repository URL"
  type        = string
}

variable "source_control_branch" {
  description = "Source control branch"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}