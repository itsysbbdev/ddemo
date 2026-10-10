variable "project" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the VNet"
}

variable "subnet_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet"
}

variable "admin_ip" {
  type        = string
  description = "IP address allowed for SSH access"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
}
