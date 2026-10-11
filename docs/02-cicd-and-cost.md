# Azure DevOps CI/CD Pipeline és Infracost Integráció

Ez a dokumentum részletezi a repository CI/CD pipeline felépítését (`azure-pipelines.yml`), a beépített Infracost költségbecslést, a szükséges Azure DevOps változókat és a lokális futtatási lehetőségeket.

---

## 1. Pipeline Felépítés (`azure-pipelines.yml`)

A pipeline célja, hogy minden kódmódosítás esetén (Pull Request és `main` ágra való push) automatikusan lefusson a minőségellenőrzés és a költségvonzat kalkulációja még a tényleges felhőbeli erőforrás-telepítés előtt.

### Általános beállítások
- **Triggerek:** `main` ágra push esetén és Pull Requesteknél (`pr: main`).
- **Agent pool:** `ubuntu-latest`.
- **Munkakönyvtár:** `environments/dev`.

### Logikai Lépések (Jobs / Steps)
1. **Előfeltételek telepítése (Terraform):**
   - Telepíti a HashiCorp hivatalos tárolójából a legfrissebb Terraform binárist az agentre.
2. **Terraform formázás és validáció:**
   - `terraform fmt -check`: Formázási szabályok betartásának ellenőrzése.
   - `terraform init -backend=false`: Providerek letöltése a validációhoz távoli backend nélkül.
   - `terraform validate`: Szintaktikai és szerkezeti érvényesség vizsgálata az `environments/dev` könyvtárban.
3. **Infracost telepítése és futtatása:**
   - Infracost CLI telepítése a hivatalos scripttel.
   - `infracost breakdown --path environments/dev`: Részletes havi és tételes költségbecslés generálása a Terraform definíciók alapján.
   - A hitelesítés a titkosított `$(INFRACOST_API_KEY)` pipeline változó segítségével történik.
4. **Terraform Init és Plan:**
   - `AzureCLI@2` task segítségével hitelesít az Azure előfizetéshez a `$(AZURE_SERVICE_CONNECTION)` service connectionön keresztül.
   - `terraform init`: Teljes backend kapcsolat felépítése (Azure Blob storage state).
   - `terraform plan -no-color`: Végrehajtási terv előállítása a meglévő és tervezett erőforrások összehasonlításával.

---

## 2. Szükséges Azure DevOps Változók és Kapcsolatok

A pipeline működéséhez az Azure DevOps felületén (Pipelines $\rightarrow$ Library / Variables) az alábbi paraméterek megadása szükséges:

| Változó / Service Connection | Típus | Leírás |
| :--- | :--- | :--- |
| `INFRACOST_API_KEY` | Secret Variable | Infracost API kulcs a felhős díjszabások és kalkulációk eléréséhez. |
| `AZURE_SERVICE_CONNECTION` | Azure Resource Manager Connection | Service Connection (Workload Identity Federation vagy SPN alapú) az Azure előfizetéshez való biztonságos hozzáféréshez. |
| `TF_WORKING_DIR` | Pipeline Variable | Alapértelmezett értéke: `environments/dev`. |

---

## 3. Infracost Konfiguráció (`infracost.yml`)

A repó gyökerében található konfiguráció határozza meg a projektek és környezetek lefedettségét:
```yaml
version: 0.1

projects:
  - path: environments/dev
    name: dev
```

---

## 4. Lokális Infracost Használat

A fejlesztők saját fejlesztői környezetükben is könnyedén ellenőrizhetik a módosításaik költségeit.

### 1. Telepítés
- **Linux:**
  ```bash
  curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
  ```
- **macOS:**
  ```bash
  brew install infracost
  ```

### 2. Hitelesítés
```bash
infracost auth login
```
Ez megnyit egy böngészőablakot és lementi az API kulcsot a `~/.config/infracost/credentials.json` fájlba.

### 3. Költségbecslés futtatása (Breakdown)
```bash
infracost breakdown --path environments/dev
```

### 4. Költségkülönbség vizsgálata (Diff)
A jelenlegi módosítások és a `main` ág közötti eltérés megtekintése:
```bash
infracost diff --path environments/dev
```

---

## 5. FinOps Előnyök

- **Balra tolt költségkontroll (Shift-Left FinOps):** A költségbecslés még a kód elfogadása előtt megtörténik.
- **Transzparencia:** Minden Pull Request láthatóvá teszi az infrastruktúra pénzügyi hatásait.
- **Megelőzés:** Elkerülhetők a tévedésből kiválasztott drága SKU-k és méretezési anomáliák.
