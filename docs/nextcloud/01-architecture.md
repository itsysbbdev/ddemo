# Nextcloud Azure Container Apps Architektúra

## Áttekintés
A tesztkörnyezet a költséghatékonyság és egyszerű üzemeltetés érdekében serverless (Azure Container Apps - ACA) alapokon fut.

## Célok és Erőforrások
- **Izoláció:** Dedikált `nextcloud` erőforráscsoport, amely tartalmaz minden `nc_` előtagú erőforrást.
- **Költséghatékonyság (Scale-to-zero):** A konténerek replikaszáma 0-ra skálázódik (`min_replicas = 0`), ha nincs bejövő forgalom, így elkerülve a felesleges költségeket.
- **Perzisztencia:** Azure Files megosztások (`nc-data-share`, `nc-db-share`) biztosítják az adatok és az adatbázis tartósságát, amelyeket az ACA platform közvetlenül volume-ként csatol a konténerekhez (SMB Mount).
- **Biztonság:** Az Ingress beállítások biztosítják a külső HTTPS hozzáférést (Nextcloud konténer), míg a MariaDB csak belső hálózati porton keresztül érhető el az alkalmazás felől.

## Ismert korlátok
- A MariaDB és más relációs adatbázisok Azure Files (SMB) feletti futtatása esetén előfordulhatnak lock vagy I/O problémák az SQLite/MariaDB szintjén. Teszteléshez és kisebb terheléshez megfelelő, éles környezetben (Production) dedikált Azure Database for MariaDB vagy PostgreSQL szolgáltatás javasolt.
