# ADR 0004: Nextcloud Azure Container Apps és Azure Files integráció

## Kontextus
A Nextcloud `0770` Linux fájljogosultságokat vár el, amit az Azure Files SMB protokollon keresztül nem támogat. Emellett az azonos ACA környezetben futó konténerek Ingress FQDN-en keresztüli kommunikációja NAT loopback hiányában időtúllépést okoz.

## Döntés
1. **Hálózat**: A belső szolgáltatás-felderítést (Service Discovery) használjuk, a `MYSQL_HOST` környezeti változó értéke a rövid név: `nc-mariadb`. Ezt a Terraform modul kezeli.
2. **Jogosultságok**: A Nextcloud `check_data_directory_permissions` ellenőrzését kikapcsoljuk egy felülbíráló konfigurációs fájl (`override.config.php`) befecskendezésével, amelyet egy automatizált poszt-telepítési szkript hajt végre a CI/CD pipeline végén.

## Következmények
- Biztosított a felhő-natív, tartós adattárolás.
- A telepítés emberi beavatkozás nélkül is sikeresen lefut.
