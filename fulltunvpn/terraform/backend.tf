terraform {
  backend "azurerm" {
    resource_group_name  = "fulltunvpn"
    storage_account_name = "stddemofulltunvpn01"
    container_name       = "tfstate"
    key                  = "fulltunvpn.tfstate"
  }
}
