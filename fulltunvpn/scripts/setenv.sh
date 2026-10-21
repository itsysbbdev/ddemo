#!/usr/bin/env bash
# Használat: source ./scripts/setenv.sh

export TARGET_RG="fulltunvpn"
export TARGET_LOCATION="austriaeast"
export TARGET_STORAGE="stddemofulltunvpn01"
export ARM_SUBSCRIPTION_ID="dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4"
export ARM_TENANT_ID="2e6b6dee-5e65-44fb-82c5-be06ba1f8b3a"
export TF_VAR_subscription_id="$ARM_SUBSCRIPTION_ID"
export TF_VAR_tenant_id="$ARM_TENANT_ID"

echo "=== [1/3] Azure kontextus beállítása ==="
az account set --subscription "$ARM_SUBSCRIPTION_ID"

echo "=== [2/3] Rögzített Azure Kontextus ==="
echo "  Subscription Name : $(az account show --query name -o tsv)"
echo "  Subscription ID   : $ARM_SUBSCRIPTION_ID"
echo "  Tenant ID         : $ARM_TENANT_ID"
echo "  Resource Group    : $TARGET_RG ($TARGET_LOCATION)"

echo "=== [3/3] Terraform Backend Key lekérése ($TARGET_STORAGE) ==="
if az storage account show -g "$TARGET_RG" -n "$TARGET_STORAGE" >/dev/null 2>&1; then
  export ARM_ACCESS_KEY=$(az storage account keys list -g "$TARGET_RG" -n "$TARGET_STORAGE" --query '[0].value' -o tsv)
  echo "  ARM_ACCESS_KEY    : [SIKERESEN BETÖLTVE]"
else
  echo "  FIGYELEM: A(z) $TARGET_STORAGE még nem érhető el! Futtasd a ./scripts/bootstrap-backend.sh szkriptet!"
fi
