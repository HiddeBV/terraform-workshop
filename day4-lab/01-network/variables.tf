variable "backend_resource_group_name" {
  description = "Name of the resource group containing the backend storage (from Sprint 1)"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group for network resources"
  type        = string
  default     = "rg-terraform-network"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "West Europe"
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-workshop"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "app_subnet_name" {
  description = "Name of the application subnet"
  type        = string
  default     = "snet-app"
}

variable "app_subnet_address_prefix" {
  description = "Address prefix for the application subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "data_subnet_name" {
  description = "Name of the data subnet"
  type        = string
  default     = "snet-data"
}

variable "data_subnet_address_prefix" {
  description = "Address prefix for the data subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "nsg_name_prefix" {
  description = "Prefix for Network Security Group names"
  type        = string
  default     = "nsg-workshop"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "workshop"
    Sprint      = "02-network"
    ManagedBy   = "terraform"
  }
}