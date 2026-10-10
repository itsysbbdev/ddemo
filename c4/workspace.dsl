workspace "DDemo Infrastructure" "DDemo Azure környezet architectúra" {
    model {
        user = person "Adminisztrátor" "Infrastruktúra kezelője és fejlesztője"
        azure = softwareSystem "Azure Felhő (DDemo)" "Microsoft Azure felhő infrastruktúra" {
            vnet = container "Network (VNet, Subnet, NSG)" "Hálózati alapok és biztonság" "Azure Virtual Network"
            compute = container "Compute (VM, NIC, IP)" "Virtuális gépek, hálózati kártyák" "Azure Virtual Machines"
        }
        
        user -> azure "Kezeli és telepíti (Terraform/OIDC)"
        user -> vnet "Csatlakozik hálózatokhoz"
        user -> compute "Bejelentkezik (SSH)"
        
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
