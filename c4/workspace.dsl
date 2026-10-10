workspace "DDemo Infrastructure" "DDemo Azure környezet architectúra" {
    model {
        user = person "Adminisztrátor" "Infrastruktúra kezelője és fejlesztője"
        azure = softwareSystem "Azure Felhő (DDemo)" "Microsoft Azure felhő infrastruktúra" {
            vnet = container "Network (VNet, Subnet, NSG)" "Hálózati alapok és biztonság" "Azure Virtual Network"
            compute = container "Compute (VM, NIC, IP)" "Virtasztikus gépek, hálózati kártyák" "Azure Virtual Machines"
            firefox = container "Firefox Web App" "Browser in browser izolált környezet" "Azure App Service (Linux Container)"
        }

        user -> azure "Kezeli és telepíti (Terraform/OIDC)"
        user -> vnet "Csatlakozik hálózatokhoz"
        user -> compute "Bejelentkezik (SSH)"
        user -> firefox "Böngészik a felületen (HTTPS)"

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
