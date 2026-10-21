# ADR-0003: Terraform Remote State tárolása Azure Storage Accountban (austriaeast)

* **Státusz:** Elfogadva (Accepted)
* **Dátum:** 2026-10-20

## 1. Kontextus
Az IaC kód állapotfájlját (`terraform.tfstate`) biztonságosan, zárolhatóan (state locking) és a Git repository-tól (`ddemo/fulltunvpn`) szigorúan elválasztva kell tárolni, közép-európai alacsony késleltetésű régióban.

## 2. Döntés
* **Régió:** `austriaeast` (Bécs – alacsony RTT Magyarország/Közép-Európa irányából).
* **Resource Group:** `fulltunvpn`
* **State Backend:** Azure Blob Storage (`stddemofulltunvpn01`, container: `tfstate`, key: `fulltunvpn.tfstate`), TLS 1.2 minimum verzióval és letiltott publikus hozzáféréssel.
