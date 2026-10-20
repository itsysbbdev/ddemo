# C4 Architecture Model - OpenVPN NVA

## 1. System Context (Level 1)
```mermaid
C4Context
    title System Context - OpenVPN NVA on Azure

    Person(admin, "Administrator", "Manages infrastructure and connects via VPN")
    System_Boundary(azure, "Microsoft Azure (austriaeast)") {
        System(vpn_nva, "OpenVPN NVA", "Ubuntu 24.04 VM running OpenVPN server")
        SystemDb(storage, "Storage Account", "stddemofulltunvpn01 / tfstate container")
    }

    Rel(admin, vpn_nva, "SSH / VPN Tunnel", "TCP/UDP")
    Rel(admin, storage, "Downloads client config", "HTTPS")
