workspace "DDemo Infrastructure" "DDemo Azure környezet architectúra" {
    model {
        user = person "Adminisztrátor" "Infrastruktúra kezelője és fejlesztője"

        azure = softwareSystem "Azure Felhő (DDemo)" "Microsoft Azure felhő infrastruktúra" {
            vnet = container "Network (VNet, Subnet, NSG)" "Hálózati alapok és biztonság" "Azure Virtual Network"
            compute = container "Compute (VM, NIC, IP)" "Virtuális gépek, hálózati kártyák" "Azure Virtual Machines"
            firefox = container "Firefox Web App" "Browser in browser izolált környezet" "Azure App Service (Linux Container)"
        }

        nextcloud = softwareSystem "Nextcloud Rendszer" "Fájlmegosztás és kollaboráció" {
            nc_aca_env = container "Azure Container Apps Env" "Serverless konténer platform" "ACA"
            nc_app = container "Nextcloud App (bb-nextcloud)" "Webes frontend és alkalmazás szerver" "Container (PHP/Apache)"
            nc_mariadb = container "MariaDB" "Relációs adatbázis" "Container (MariaDB)"
            nc_storage = container "Azure Files Storage" "Perzisztens adat és adatbázis tárhely" "Storage Account"

            nc_app -> nc_mariadb "Olvas/Ír adatokat"
            nc_app -> nc_storage "Fájlok tárolása (SMB Mount)"
            nc_mariadb -> nc_storage "Adatbázis fájlok (SMB Mount)"
            nc_aca_env -> nc_app "Futásidőt biztosít"
            nc_aca_env -> nc_mariadb "Futásidőt biztosít"
        }

        azureDevOps = softwareSystem "Azure DevOps Pipeline" "CI/CD automatizáció és validáció (azure-pipelines.yml)"

        user -> azureDevOps "Kódot commitol és Pull Requestet nyit (Git)"
        user -> azure "Kezeli és felügyeli (Azure Portal / CLI)"
        user -> vnet "Csatlakozik hálózatokhoz"
        user -> compute "Bejelentkezik (SSH)"
        user -> firefox "Böngészik a felületen (HTTPS)"
        user -> nc_app "Böngészi (HTTPS)"

        azureDevOps -> azure "Terraform init és plan végrehajtása ($(AZURE_SERVICE_CONNECTION))"
        azureDevOps -> nextcloud "Infrastruktúra komponensek telepítése és validálása"

        compute -> vnet "Hálózati hozzáférést használ"
    }

    views {
        systemContext azure "SystemContext" {
            include *
            autoLayout
        }
        container azure "ContainerView" {
            include *
            autoLayout
        }
        theme default
    }
}

