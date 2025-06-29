variable "resource_group_name" {
  description = "Name of the resource group for database resources"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "database_server_name" {
  description = "Name of the database server"
  type        = string
}

variable "database_name" {
  description = "Name of the database"
  type        = string
}

variable "database_admin_username" {
  description = "Database administrator username"
  type        = string
  sensitive   = true
}

variable "database_admin_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}

variable "vnet_id" {
  description = "ID of the virtual network"
  type        = string
}

variable "data_subnet_id" {
  description = "ID of the data subnet for private endpoint"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}