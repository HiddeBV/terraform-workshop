variable "resource_group_name" {
  description = "Name of the resource group for network resources"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = string
}

variable "app_subnet_name" {
  description = "Name of the application subnet"
  type        = string
}

variable "app_subnet_address_prefix" {
  description = "Address prefix for the application subnet"
  type        = string
}

variable "data_subnet_name" {
  description = "Name of the data subnet"
  type        = string
}

variable "data_subnet_address_prefix" {
  description = "Address prefix for the data subnet"
  type        = string
}

variable "nsg_name_prefix" {
  description = "Prefix for Network Security Group names"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}