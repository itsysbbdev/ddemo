# HLD: Költségmenedzsment (Cost Management)

## Költségoptimalizálási stratégia
1. **Erőforrás méretezés:** "B" szériás (pl. Standard_B2s) Burstable VM-ek használata a fejlesztői (Dev) környezetben a költségek alacsonyan tartása végett.
2. **Kikapcsolási automatizáció:** A Dev gépek munkaidőn kívül automatikusan leállításra kerülnek.
3. **Erőforrás életciklus:** Rövid életű (Ephemeral) diszkek támogatása ott, ahol az adat perzisztencia nem követelmény.
4. **Költségkeretek (Budgets):** Riasztások beállítása az előfizetés szintjén (Billing Alerts) 80%-os és 100%-os keretkimerülés esetén.

## Firefox-app (App Service B1) költségkontroll és életciklus

Az új Remote Browser Isolation (Firefox-app) szolgáltatás egy B1-es (Basic) App Service Plan-en fut.
- **Becsült költség:** ~13 USD / hó.

A szolgáltatás futása (a konténer és a bejövő forgalom) egyszerűen felfüggeszthető és újraindítható az alábbi CLI parancsokkal:

**Leállítás:**
```bash
az webapp stop --name "firefox-app-bb" --resource-group "Firefox-app"
```

**Újraindítás:**
```bash
az webapp start --name "firefox-app-bb" --resource-group "Firefox-app"
```

**Fontos Azure sajátosság:** 
A leállítás (stop) állapotban az App Service Plan (B1) lefoglalt kapacitásként továbbra is számlázódik. Amennyiben hosszabb távra teljes költségmentesítés (0 USD) a cél, az erőforrást ideiglenesen le kell bontani a Terraform segítségével (`terraform destroy -target=module.firefox_app`), vagy az App Service Plan SKU-t le kell minősíteni.
