# LLD: Névkonvenciók és Címkézési stratégia (Tagging)

## Névkonvenció
Formátum: `<projekt>-<környezet>-<erőforrás_típus>`
Példa:
- VNet: `ddemo-dev-vnet`
- VM: `ddemo-dev-vm01`

## Kötelező Tagek
Minden erőforrásra kötelezően alkalmazandó `tags` változók a gyökér (root) szinten:
- `Environment`: dev | test | prod
- `Project`: ddemo
- `ManagedBy`: terraform
- `Owner`: (felelős személy vagy csapat)
