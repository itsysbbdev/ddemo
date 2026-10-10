#!/bin/bash
set -e

RG_NAME="rg-terraform-state"
LOCATION="austriaeast"
SA_NAME="sttfstate$(shuf -i 10000-99999 -n 1)"
CONTAINER_NAME="tfstate"

echo "=== Terraform Azure Backend Bootstrapping ==="
echo "Resource Group: $RG_NAME"
echo "Location: $LOCATION"
echo "Storage Account Name (random): $SA_NAME"

az group create --name $RG_NAME --location $LOCATION -o none
az storage account create --resource-group $RG_NAME \
  --name $SA_NAME --sku Standard_LRS --encryption-services blob -o none
az storage container create --name $CONTAINER_NAME \
  --account-name $SA_NAME -o none

echo "=== Backend inicializálva! ==="
echo "Frissítsd az environments/dev/backend.tf fájlt:"
echo "resource_group_name  = \"$RG_NAME\""
echo "storage_account_name = \"$SA_NAME\""
echo "container_name       = \"$CONTAINER_NAME\""
echo "key                  = \"dev.terraform.tfstate\""
