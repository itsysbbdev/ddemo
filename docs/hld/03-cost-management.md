# HLD: Költségmenedzsment (Cost Management)

## Költségoptimalizálási stratégia
1. **Erőforrás méretezés:** "B" szériás (pl. Standard_B2s) Burstable VM-ek használata a fejlesztői (Dev) környezetben a költségek alacsonyan tartása végett.
2. **Kikapcsolási automatizáció:** A Dev gépek munkaidőn kívül automatikusan leállításra kerülnek.
3. **Erőforrás életciklus:** Rövid életű (Ephemeral) diszkek támogatása ott, ahol az adat perzisztencia nem követelmény.
4. **Költségkeretek (Budgets):** Riasztások beállítása az előfizetés szintjén (Billing Alerts) 80%-os és 100%-os keretkimerülés esetén.
