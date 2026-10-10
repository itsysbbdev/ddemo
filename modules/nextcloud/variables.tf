variable "location" {
  type        = string
  description = "Azure region"
}

variable "nc_resource_group_name" {
  type        = string
  description = "Name of the Nextcloud resource group"
}

variable "nc_storage_account_name" {
  type        = string
  description = "Name of the Nextcloud storage account"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
