# Low-Level Design (LLD) – Azure Full-Tunnel OpenVPN

| Erőforrás típusa | Azure Erőforrás Neve | Paraméterek / Specifikáció |
| :--- | :--- | :--- |
| Subscription | ddemo | Cél előfizetés |
| Resource Group | fulltunvpn | Régió: austriaeast |
| Storage Account | stddemofulltunvpn01 | Standard_LRS, StorageV2, TLS1_2, Container: tfstate |
| Virtual Network | vnet-fulltunvpn-ae | Address Space: 10.20.0.0/16 |
| Subnet | snet-vpn-gateway | Address Prefix: 10.20.1.0/24 |
| Public IP | pip-fulltunvpn-ae | Standard SKU, Static allokáció |
| NSG | nsg-fulltunvpn-ae | Inbound: UDP/1194 (OpenVPN), TCP/22 (SSH) |
| NIC | nic-vm-openvpn-ae | Private IP: 10.20.1.4 (Static), ip_forwarding_enabled = true |
| Virtual Machine | vm-openvpn-ae | Standard_B2s, Ubuntu 24.04 LTS |
