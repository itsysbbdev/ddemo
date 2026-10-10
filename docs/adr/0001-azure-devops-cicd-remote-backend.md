# ADR 0001: Azure Blob Storage használata Terraform Remote Backendként

## Állapot
Elfogadva

## Kontextus
A Terraform állapota (state) tartalmazza az infrastruktúra aktuális leképzését. Helyi (local) tárolás esetén nem támogatott a csapatmunka, és biztonsági kockázatot jelent a state fájl elvesztése vagy az abban szereplő secret-ek kiszivárgása.

## Döntés
A Terraform state tárolásához egy dedikált Azure Storage Account Blob Container-ét használjuk (AzureRM Backend).

## Következmények
- **Előnyök:** Natív lockolás, RBAC integráció, magas rendelkezésre állás.
- **Hátrányok:** A backend storage erőforrást a Terraform futtatása előtt manuálisan (vagy külön scripttel) létre kell hozni (bootstrap).
