# Hibaelhárítási (Troubleshooting) Runbook

1. **State Lock hiba (Error acquiring the state lock):**
   - *Ok:* Egy korábbi Terraform folyamat megszakadt, és a Blob tárolón lévő lock fájl (lease) beragadt.
   - *Megoldás:* Töröld a lease-t (Break Lease) az Azure Portalon a Storage Account -> Containers menüjében a tfstate fájlról.

2. **OIDC Authentication Failed:**
   - *Ok:* Lejárt vagy hibás Federated Credentials beállítás.
   - *Megoldás:* Ellenőrizd a Service Principal OIDC "Federated credentials" beállítását az Azure Entra ID-ben.
