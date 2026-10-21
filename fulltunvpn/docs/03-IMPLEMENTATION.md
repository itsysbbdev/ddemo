# Implementációs és Diagnosztikai Dokumentáció (Runbook)

1. Fázis 1 – Backend Bootstrap: scripts/bootstrap-backend.sh futtatása (fulltunvpn RG + stddemofulltunvpn01).
2. Fázis 2 – Terraform Init & Apply: A terraform/ mappában lévő IaC kód futtatása.
3. Fázis 3 – Cloud-Init PKI & OpenVPN: Automatikus PKI és /home/azureuser/client1.ovpn generálás.
4. Fázis 4 – Tesztelés és Diagnosztika: Kliens csatlakozás és kilépő IP ellenőrzés (curl ifconfig.me).
