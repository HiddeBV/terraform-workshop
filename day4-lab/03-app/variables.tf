variable "network_resource_group_name" {
  description = "Name of the resource group containing network resources (from Sprint 2)"
  type        = string
}

variable "keyvault_resource_group_name" {
  description = "Name of the resource group containing Key Vault resources (from Sprint 3)"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network (from Sprint 2)"
  type        = string
  default     = "vnet-workshop"
}

variable "app_subnet_name" {
  description = "Name of the application subnet (from Sprint 2)"
  type        = string
  default     = "snet-app"
}

variable "key_vault_name" {
  description = "Name of the Key Vault (from Sprint 3)"
  type        = string
}

variable "managed_identity_name" {
  description = "Name of the managed identity (from Sprint 3)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group for App Service resources"
  type        = string
  default     = "rg-terraform-app"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "West Europe"
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
  default     = "asp-workshop"
}

variable "app_service_plan_sku" {
  description = "SKU for the App Service Plan"
  type        = string
  default     = "B1"
  
  validation {
    condition     = contains(["B1", "B2", "B3", "S1", "S2", "S3", "P1v2", "P2v2", "P3v2"], var.app_service_plan_sku)
    error_message = "App Service Plan SKU must be a valid SKU."
  }
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
  default     = "app-workshop"
}

variable "source_control_repo_url" {
  description = "Repository URL for source control deployment"
  type        = string
  default     = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
}

variable "source_control_branch" {
  description = "Branch for source control deployment"
  type        = string
  default     = "master"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "workshop"
    Sprint      = "04-app"
    ManagedBy   = "terraform"
  }
}