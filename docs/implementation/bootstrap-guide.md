# Zero-Touch Bootstrap Útmutató

Ez az útmutató bemutatja, hogyan építsd fel a környezetet a nulláról, teljesen automatizált módon.

## 1. Előfeltételek
- Azure CLI telepítve és bejelentkezve (`az login`).
- Terraform CLI (>= 1.5.0) telepítve.

## 2. Állapotkezelő (Backend) inicializálása
Futtasd a `scripts/bootstrap-azure-backend.sh` scriptet. Ez létrehozza azt a Storage Accountot, amely a Terraform state fájlt fogja tárolni.
```bash
cd scripts
./bootstrap-azure-backend.sh
```

## 3. Paraméterezés
Készítsd el a konfigurációt a sablon alapján:
```bash
cd ../environments/dev
cp terraform.tfvars.example terraform.tfvars
```
Töltsd ki az adataiddal (RG név, hely, SSH IP)!

## 4. Terraform Futtatás
```bash
terraform init
terraform plan -out=tfplan
terraform apply "tfplan"
```
A kimenet (Output) megadja a létrehozott VM publikus IP címét.
