resource "azurerm_service_plan" "asp" {
  name                = "${var.app_name}-asp"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.asp.id
  https_only          = true

  site_config {
    always_on = true
    websockets_enabled = var.websockets_enabled
    application_stack {
      docker_image_name   = var.docker_image
      docker_registry_url = var.docker_registry_url
    }
  }

  app_settings = merge({
    "WEBSITES_PORT" = var.websites_port
  }, var.app_settings)

  tags = var.tags
}
