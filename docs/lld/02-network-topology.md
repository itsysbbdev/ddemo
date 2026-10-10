# LLD: Hálózati Topológia és NSG

## IP Címzési terv (Dev környezet)
- **VNet:** `10.0.0.0/16`
- **Alhálózat (AppSubnet):** `10.0.1.0/24`

## Hálózati Biztonsági Csoport (NSG) Szabályok
Minden alhálózathoz az alábbi bejövő (Inbound) szabályok kerülnek alkalmazásra:
1. `Allow-SSH`: 22-es port (TCP), Forrás: Kijelölt Admin IP.
2. `Allow-HTTP/HTTPS`: 80, 443 (TCP), Forrás: Any (Kizárólag publikus szolgáltatások esetén).
3. `Deny-All-Inbound`: Minden más forgalom blokkolása.
