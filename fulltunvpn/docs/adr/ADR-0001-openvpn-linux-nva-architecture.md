# ADR-0001: Linux alapú OpenVPN NVA használata Natív Azure VPN Gateway helyett

* **Státusz:** Elfogadva (Accepted)
* **Dátum:** 2026-10-20
* **Döntéshozók:** Cloud & Security Architecture
* **Környezet:** `ddemo` Azure Subscription / `fulltunvpn` Resource Group (`austriaeast`)

## 1. Kontextus és Problémafelvetés
A cél egy olyan Full-Tunnel OpenVPN szolgáltatás kialakítása Azure-ban, amelynél a csatlakozó VPN kliensek összes internet irányú forgalma (`0.0.0.0/0`) ugyanazon a dedikált, statikus publikus IP címen keresztül lép ki az internetre, amelyen a VPN csatorna felépül.

## 2. Vizsgált Opciók
1. **Opció A: Natív Azure VPN Gateway (PaaS) + Azure Firewall / NVA**
   * A natív Azure `Virtual Network Gateway` nem végez SNAT-ot az internet (`0.0.0.0/0`) irányába. Külön Azure Firewall vagy Egress NVA + Route Table (UDR) szükséges a `GatewaySubnet`-en. Emiatt a bejövő VPN végpont IP-je és a kimenő SNAT IP eltérne, a provizionálási idő 30-45 perc, a havi költség pedig aránytalanul magas.
2. **Opció B: Dedikált Linux VM alapú OpenVPN NVA (Ubuntu 24.04 LTS)**
   * Egyetlen statikus `Standard` Public IP cím (`pip-fulltunvpn-ae`) rendelhető a VM hálózati interfészéhez (`nic-vm-openvpn-ae`). Az Azure NIC `ip_forwarding_enabled = true` beállításával, a Linux kernel `net.ipv4.ip_forward=1` paraméterével és `iptables MASQUERADE` szabállyal a VPN csatorna végpontja és a kimenő SNAT IP cím 100%-ban megegyezik.

## 3. Döntés és Következmények
Az **Opció B (Linux VM alapú OpenVPN NVA)** architektúrát választjuk, `cloud-init` alapú teljesen automatizált telepítéssel.
* **Pozitív:** Egyetlen statikus publikus IP cím (`pip-fulltunvpn-ae`), alacsony üzemeltetési költség (`Standard_B2s`), gyors Terraform provizionálás (~2 perc), teljes kontroll az OpenVPN, PKI és DNS paraméterek felett.
* **Negatív / Mitigáció:** IaaS szintű OS frissítésekről gondoskodni kell (`unattended-upgrades` automatikus biztonsági frissítésekkel kezelve).
