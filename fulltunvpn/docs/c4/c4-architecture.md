# C4 Architektúra Modell – Full-Tunnel OpenVPN (Azure IaC)

## C1 – Rendszerkontextus Diagram (System Context)

~~~mermaid
C4Context
    title System Context diagram for Azure Full-Tunnel VPN (fulltunvpn)
    Person(user, "VPN Kliens / Felhasználó", "Távoli eszköz OpenVPN klienssel")
    System(vpn_system, "Azure Full-Tunnel VPN System", "OpenVPN NVA az austriaeast régióban, amely minden kliens forgalmat statikus IP-re NAT-ol.")
    System_Ext(internet, "Publikus Internet / Célrendszerek", "Külső webhelyek és API-k, amelyek a VPN statikus IP-jét látják.")
    System_Ext(dns, "Publikus Biztonságos DNS", "Cloudflare (1.1.1.1) / Quad9 (9.9.9.9)")

    Rel(user, vpn_system, "Titkosított OpenVPN csatorna (0.0.0.0/0)", "UDP 1194 / TLS-Crypt")
    Rel(vpn_system, dns, "DNS feloldás a csatornán keresztül", "UDP/TCP 53")
    Rel(vpn_system, internet, "Kimenő internetes forgalom SNAT-olva (pip-fulltunvpn-ae)", "HTTPS/TCP/UDP")
~~~

## C2 – Konténer / Infrastruktúra Diagram (Container Level)

~~~mermaid
C4Container
    title Container / Infrastructure Diagram - Resource Group: fulltunvpn (austriaeast)
    Person(client, "OpenVPN Kliens", "10.8.0.x (tun0)")

    Container_Boundary(rg, "Azure Resource Group: fulltunvpn") {
        ContainerDb(tfstate, "stddemofulltunvpn01", "Azure Blob Storage", "Terraform Remote State (tfstate)")
        
        Container_Boundary(vnet, "VNet: vnet-fulltunvpn-ae (10.20.0.0/16)") {
            Container(pip, "pip-fulltunvpn-ae", "Standard Static Public IP", "Bejövő VPN végpont & Kimenő SNAT IP")
            Container(nsg, "nsg-fulltunvpn-ae", "Network Security Group", "Allow UDP 1194, Allow TCP 22")
            Container(nic, "nic-vm-openvpn-ae", "Azure NIC (10.20.1.4)", "ip_forwarding_enabled = true")
            Container(vm, "vm-openvpn-ae", "Ubuntu 24.04 LTS (Standard_B2s)", "OpenVPN Server + Easy-RSA PKI + Linux Kernel Router")
        }
    }

    System_Ext(target, "Cél Internet Szolgáltatás", "Külvilág (0.0.0.0/0)")

    Rel(client, pip, "1. OpenVPN Tunnel", "UDP 1194")
    Rel(pip, nic, "2. Inbound DNAT / Outbound SNAT", "Azure SDN")
    Rel(nsg, nic, "Szűri a forgalmat", "NSG Rules")
    Rel(nic, vm, "Csomagtovábbítás", "eth0")
    Rel(pip, target, "3. Egress forgalom statikus IP-vel", "SNAT")
~~~

## C3 – Komponens Diagram (vm-openvpn-ae belső felépítése)

~~~mermaid
C4Component
    title Component Diagram - vm-openvpn-ae (OpenVPN NVA)
    Container_Boundary(vm_boundary, "vm-openvpn-ae (Ubuntu 24.04)") {
        Component(cloud_init, "cloud-init Provisioner", "Bash / YAML", "Első indításkor telepíti a csomagokat, PKI-t és hálózati szabályokat.")
        Component(easyrsa, "Easy-RSA 3 PKI", "PKI Engine", "Generálja a CA, Server és Client tanúsítványokat + tls-crypt kulcsot.")
        Component(ovpn, "OpenVPN Daemon", "systemd: openvpn-server@server", "Kezeli a tun0 (10.8.0.0/24) interfészt és leküldi a redirect-gateway def1 szabályt.")
        Component(kernel_net, "Linux Kernel & Netfilter", "sysctl + iptables", "net.ipv4.ip_forward=1 és POSTROUTING MASQUERADE (10.8.0.0/24 -> eth0).")
    }

    Rel(cloud_init, easyrsa, "Inicializálja")
    Rel(cloud_init, ovpn, "Konfigurálja és elindítja")
    Rel(cloud_init, kernel_net, "Beállítja az IP forwardot és NAT-ot")
    Rel(ovpn, kernel_net, "Átadja a dekapszulált kliens csomagokat", "tun0 -> eth0")
~~~
