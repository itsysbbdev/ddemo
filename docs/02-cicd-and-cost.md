# Azure DevOps CI/CD Pipeline

Ez a dokumentum részletezi a repository natív Terraform CI/CD pipeline felépítését (`azure-pipelines.yml`), a szükséges Azure DevOps változókat és a folyamat működését.

---

## 1. Pipeline Felépítés (`azure-pipelines.yml`)

A pipeline célja, hogy minden kódmódosítás esetén (Pull Request és `main` ágra való push) automatikusan lefusson a minőségellenőrzés, formázás és a végrehajtási terv generálása még a tényleges felhőbeli erőforrás-telepítés előtt, kizárólag nyílt forráskódú és natív Terraform eszközökre támaszkodva.

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
3. **Terraform Init és Plan:**
   - `AzureCLI@2` task segítségével hitelesít az Azure előfizetéshez a `$(AZURE_SERVICE_CONNECTION)` service connectionön keresztül.
   - `terraform init`: Teljes backend kapcsolat felépítése (Azure Blob storage state).
   - `terraform plan -no-color`: Végrehajtási terv előállítása a meglévő és tervezett erőforrások összehasonlításával.

---

## 2. Szükséges Azure DevOps Változók és Kapcsolatok

A pipeline működéséhez az Azure DevOps felületén (Pipelines $\rightarrow$ Service Connections / Variables) az alábbi paraméterek megadása szükséges:

| Változó / Service Connection | Típus | Leírás |
| :--- | :--- | :--- |
| `AZURE_SERVICE_CONNECTION` | Azure Resource Manager Connection | Service Connection (Workload Identity Federation vagy SPN alapú) az Azure előfizetéshez való biztonságos hozzáféréshez. |
| `TF_WORKING_DIR` | Pipeline Variable | Alapértelmezett értéke: `environments/dev`. |

---

## 3. Helyi Futtatás és Fejlesztői Munkafolyamat

A fejlesztők saját gépükön közvetlenül a standard Terraform CLI parancsokkal validálhatják a munkájukat:

### 1. Formázás ellenőrzése
```bash
terraform fmt -check environments/dev
```

### 2. Validáció
```bash
cd environments/dev
terraform init -backend=false
terraform validate
```

### 3. Tervezés (Helyi Plan)
Azure CLI bejelentkezést követően (`az login`):
```bash
cd environments/dev
terraform init
terraform plan
```

