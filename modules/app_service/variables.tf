variable "app_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "sku_name" {
  type    = string
  default = "B1"
}
variable "docker_image" { type = string }
variable "docker_registry_url" { type = string }
variable "websites_port" { type = string }
variable "websockets_enabled" {
  type    = bool
  default = false
}
variable "app_settings" {
  type    = map(string)
  default = {}
}
variable "tags" {
  type    = map(string)
  default = {}
}
