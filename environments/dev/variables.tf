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

variable "vm_size" {
  type        = string
  description = "Size of the Virtual Machine"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "tags" {
  type        = map(string)
  description = "Tags for resources"
}
