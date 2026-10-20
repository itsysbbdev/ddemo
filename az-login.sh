#!/usr/bin/env bash
set -euo pipefail

# Azure MFA Login & Subscription beállító script (DDemo)
TENANT_ID="2e6b6dee-5e65-44fb-82c5-be06ba1f8b3a"
SUBSCRIPTION_ID="dfbe2d24-6ec8-49a9-9beb-e3a1314f2cc4"

echo "Bejelentkezés az Azure tenantba ($TENANT_ID)..."
az login --tenant "$TENANT_ID"

echo "Aktív előfizetés beállítása: DDemo ($SUBSCRIPTION_ID)..."
az account set --subscription "$SUBSCRIPTION_ID"

echo "Sikeres belépés! Jelenlegi kontextus:"
az account show --output table
