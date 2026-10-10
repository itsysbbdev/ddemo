module "networking" {
  source = "../../modules/networking"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = var.resource_group_name
  vnet_address_space  = var.vnet_address_space
  subnet_prefixes     = var.subnet_prefixes
  admin_ip            = var.admin_ip
  tags                = var.tags
}

module "compute" {
  source = "../../modules/compute"

  project             = var.project
  environment         = var.environment
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.networking.subnet_id
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  tags                = var.tags
}
