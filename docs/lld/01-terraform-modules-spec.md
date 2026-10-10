# Low-Level Design (LLD): Terraform Modulok Specifikációja

## 1. Networking Modul (`modules/networking`)
- **Feladata:** VNet, Subnet, NSG, és NSG Association létrehozása.
- **Bemenetek (Variables):**
  - `vnet_address_space` (list(string)): A virtuális hálózat címe.
  - `subnet_prefixes` (list(string)): Az alhálózat(ok) prefixei.
  - `location`, `resource_group_name` (string)
- **Kimenetek (Outputs):**
  - `subnet_id`: A létrehozott subnet azonosítója (továbbítva a Compute modulnak).

## 2. Compute Modul (`modules/compute`)
- **Feladata:** Public IP, NIC, és Linux Virtual Machine létrehozása.
- **Bemenetek (Variables):**
  - `subnet_id` (string): Kapcsolódás a hálózathoz.
  - `vm_size` (string): Alapértelmezetten "Standard_B2s".
  - `admin_username` (string)
- **Kimenetek (Outputs):**
  - `public_ip_address`: A publikus IP cím az eléréshez.

## 3. App Service Modul (`modules/app_service`)
- **Feladata:** Azure App Service Plan (Linux) és egy Docker alapú Linux Web App létrehozása.
- **Bemenetek (Variables):**
  - `app_name`, `location`, `resource_group_name` (string)
  - `sku_name` (string): Alapértelmezett B1.
  - `docker_image` és `docker_registry_url` (string): A használandó konténer elérhetősége.
  - `websites_port` (string): Belső konténer port (pl. 3000).
  - `app_settings` (map(string)): Környezeti változók a konténernek.
- **Kimenetek (Outputs):**
  - `app_service_default_hostname`: Generált azurewebsites.net domain.
