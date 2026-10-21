# 1. Hálózat modul hívása
module "networking" {
  source = "../../modules/networking"

  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = "${var.prefix}-vnet"
  vnet_address_space  = ["10.0.0.0/16"]
  subnet_name         = "${var.prefix}-subnet"
  subnet_prefixes     = ["10.0.1.0/24"]
  nsg_name            = "${var.prefix}-nsg"
  tags                = { Environment = var.environment }
}

# 2. Számítási feladatok / NVA modul hívása
module "compute" {
  source = "../../modules/compute"

  resource_group_name = var.resource_group_name
  location            = var.location
  pip_name            = "${var.prefix}-pip"
  nic_name            = "${var.prefix}-nic"
  ip_config_name      = "${var.prefix}-ip-config"
  subnet_id           = module.networking.subnet_id
  nsg_id              = module.networking.nsg_id
  vm_name             = "${var.prefix}-vm"
  vm_size             = "Standard_B1s"
  admin_username      = "azureuser"
  public_key          = file("~/.ssh/id_rsa.pub") # Vagy a meglévő publikus kulcsod útvonala
  tags                = { Environment = var.environment }
}
