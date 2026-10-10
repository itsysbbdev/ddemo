# Hibaelhárítási (Troubleshooting) Runbook

1. **State Lock hiba (Error acquiring the state lock):**
   - *Ok:* Egy korábbi Terraform folyamat megszakadt, és a Blob tárolón lévő lock fájl (lease) beragadt.
   - *Megoldás:* Töröld a lease-t (Break Lease) az Azure Portalon a Storage Account -> Containers menüjében a tfstate fájlról.

2. **OIDC Authentication Failed:**
   - *Ok:* Lejárt vagy hibás Federated Credentials beállítás.
   - *Megoldás:* Ellenőrizd a Service Principal OIDC "Federated credentials" beállítását az Azure Entra ID-ben.

## Napi üzemeltetési eljárások (Operations & Maintenance)

A karbantartási, frissítési vagy hibaelhárítási folyamatok során hasznos lehet az alkalmazások gyors leállítása és újraindítása anélkül, hogy a teljes infrastruktúrát újra kellene építeni.

**Firefox-app (Remote Browser) gyors karbantartási rutinja:**

- **Szolgáltatás leállítása** (ideiglenes hozzáférés megszüntetése vagy karbantartás céljából):
  ```bash
  az webapp stop --name "firefox-app-bb" --resource-group "Firefox-app"
  ```

- **Szolgáltatás újraindítása** (beragadt konténer újraindítása vagy frissítések érvényesítése):
  ```bash
  az webapp start --name "firefox-app-bb" --resource-group "Firefox-app"
  ```
