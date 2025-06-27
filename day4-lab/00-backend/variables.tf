variable "resource_group_name" {
  description = "Name of the resource group for backend infrastructure"
  type        = string
  default     = "rg-terraform-backend"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "West Europe"
}

variable "storage_account_prefix" {
  description = "Prefix for the storage account name (will be suffixed with random string)"
  type        = string
  default     = "stterraform"

  validation {
    condition     = length(var.storage_account_prefix) <= 16 && can(regex("^[a-z0-9]*$", var.storage_account_prefix))
    error_message = "Storage account prefix must be 16 characters or less and contain only lowercase letters and numbers."
  }
}

variable "container_name" {
  description = "Name of the storage container for Terraform state"
  type        = string
  default     = "tfstate"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "workshop"
    Purpose     = "terraform-backend"
    ManagedBy   = "terraform"
  }
}