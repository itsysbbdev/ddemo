module "networking" {
  source              = "../../modules/networking"
  location            = "austriaeast"
  resource_group_name = "anitacuki"
  vnet_name           = "anitacuki-vmVNET"
  vnet_address_space  = ["10.0.0.0/16"]
  subnet_name         = "anitacuki-vmSubnet"
  subnet_prefixes     = ["10.0.0.0/24"]
  nsg_name            = "anitacuki-nsg"
  tags                = {}
}

module "compute" {
  source              = "../../modules/compute"
  location            = "austriaeast"
  resource_group_name = "anitacuki"
  pip_name            = "anitacuki-pip"
  nic_name            = "anitacuki-vmVMNic"
  ip_config_name      = "ipconfiganitacuki-vm"
  subnet_id           = module.networking.subnet_id
  nsg_id              = module.networking.nsg_id
  vm_name             = "anitacuki-vm"
  vm_size             = "Standard_B2ms"
  admin_username      = "azureuser"
  public_key          = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCVxYz2l/Y91A7MOA+sezKSqlgJNa3BOQFaf+Ql+nRW1LyT2NnFq9xyD4AYnIGTbPEbglfYeUfaCIpFne7fE/ydDijFAGoCz2efUBEj2WFo7Ut6w7cQCk1PrJLyuK8qOpoA947i3FyGC12lXg0noqRjT4kDcxYTUcfqOyhNuMjlrzTfmFtesRDH8pOnC+Q+HuK8Md8LnGmiR0B80kRTf/f49Cz6AMrDh/++rOAvYL96wsnRLOW3M+ORwYfjlDCL4pAuvLU2DHZpfoPC43cA7bGZ+peiJbAs7kfhj0ehmuzW+tk60cqWz+d9DdJ6wSkpoGlvKCUsfrHAoKqw2/hyp2Sp bbadmin@Acer-sw-ryzen"
  tags                = {}
}

resource "azurerm_resource_group" "firefox_rg" {
  name     = "Firefox-app"
  location = "austriaeast"
}

module "firefox_app" {
  source              = "../../modules/app_service"
  app_name            = "firefox-app-bb"
  location            = azurerm_resource_group.firefox_rg.location
  resource_group_name = azurerm_resource_group.firefox_rg.name
  sku_name            = "B1"
  docker_image        = "linuxserver/firefox:latest"
  docker_registry_url = "https://lscr.io"
  websites_port       = "3000"
  websockets_enabled  = true
  
  app_settings = {
    "CUSTOM_USER"                         = "admin"
    "PASSWORD"                            = "SecurePassword123!"
    "WEBSITES_CONTAINER_START_TIME_LIMIT" = "1800"
  }
}
