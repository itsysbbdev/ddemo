# ADR-0002: Tanúsítvány alapú (PKI) hitelesítés beágyazott .ovpn profillal

* **Státusz:** Elfogadva (Accepted)
* **Dátum:** 2026-10-20

## 1. Kontextus
Az OpenVPN kliensek biztonságos, ugyanakkor hordozható hitelesítéséhez és a gyors csatlakozáshoz meg kellett határozni a kriptográfiai és autentikációs mechanizmust.

## 2. Döntés
Tanúsítvány alapú **Easy-RSA 3 PKI** hitelesítést alkalmazunk `tls-crypt` csatornavédelemmel és `ECDSA / AES-256-GCM` kriptográfiával. A `cloud-init` a szerver első indulásakor automatikusan legenerálja a CA, szerver és kliens tanúsítványokat, majd egyetlen önálló (inline) `.ovpn` profilba ágyazza (`<ca>`, `<cert>`, `<key>`, `<tls-crypt>`).

## 3. Következmények
* A kliens oldalon nincs szükség különálló `.crt`, `.key` és `ta.key` fájlok másolására; egyetlen `client1.ovpn` fájl importálásával azonnal működik a Full-Tunnel kapcsolat.
* A `tls-crypt` elrejti az OpenVPN UDP 1194 portot az aktív portszkennerek és DPI (Deep Packet Inspection) vizsgálatok elől.
