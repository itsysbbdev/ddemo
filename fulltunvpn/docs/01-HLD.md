# High-Level Design (HLD) – Azure Full-Tunnel OpenVPN

## 1. Vezetői Összefoglaló
A projekt célja egy Infrastructure as Code (Terraform) alapú, teljesen automatizált Full-Tunnel OpenVPN átjáró létrehozása a ddemo Azure előfizetés fulltunvpn erőforráscsoportjában (austriaeast régió). A csatlakozó kliensek teljes internetes forgalma (0.0.0.0/0) egyetlen dedikált statikus publikus IP címen (pip-fulltunvpn-ae) lép ki az internetre.

## 2. Biztonsági és Hálózati Alapelvek
1. **Teljes forgalomterelés (Full-Tunnel):** redirect-gateway def1 utasítással.
2. **DNS Leak védelem:** 1.1.1.1 és 9.9.9.9 DNS szerverek leküldése a csatornán.
3. **Kriptográfia:** TLS 1.3, tls-crypt előmegosztott kulcs, AES-256-GCM.
