#!/bin/bash
# Ezt a szkriptet a CI/CD pipeline utolsó lépéseként kell meghívni az Azure DevOps-ban.
# Felülbírálja a Nextcloud mappa-ellenőrzését anélkül, hogy interaktív shellre lenne szükség.

echo "Konfiguráció injektálása a Nextcloud konténerbe..."
az containerapp exec \
  --name bb-nextcloud \
  --resource-group nextcloud \
  --command "bash -c 'echo PD9waHAKJENPTkZJRyA9IGFycmF5ICgKICAnY2hlY2tfZGF0YV9kaXJlY3RvcnlfcGVybWlzc2lvbnMnID0+IGZhbHNlLAopOwo= | base64 -d > /var/www/html/config/override.config.php'"
echo "Konfiguráció sikeresen beállítva."
