terraform {
  backend "azurerm" {
    # Bootstrap script által biztosítva:
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstate12345"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}
