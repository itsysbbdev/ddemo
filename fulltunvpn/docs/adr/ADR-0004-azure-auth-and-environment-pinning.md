# ADR-0004: Determinisztikus Azure CLI és Terraform környezeti paraméterek rögzítése

* **Státusz:** Elfogadva (Accepted)
* **Dátum:** 2026-10-20

## 1. Kontextus
Az Azure CLI munkamenetek és a Terraform `azurerm` (v4.x) provider futtatása során elengedhetetlen, hogy a kód ne egy véletlenszerűen aktív előfizetésbe, hanem garantáltan a `ddemo` előfizetésbe és a `fulltunvpn` erőforráscsoportba dolgozzon.

## 2. Döntés
* Létrehozunk egy `scripts/setenv.sh` környezet-inicializáló szkriptet (`source scripts/setenv.sh`), amely ellenőrzi az Azure CLI belépést, kiválasztja a cél előfizetést, és beállítja az `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID` és `ARM_ACCESS_KEY` környezeti változókat.
* A `terraform/providers.tf` fájlban az `azurerm` provider explicit módon megkapja a `subscription_id` és `tenant_id` paramétereket is.
