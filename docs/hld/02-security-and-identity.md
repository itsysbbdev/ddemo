# HLD: Biztonsági Architektúra és Identitáskezelés

## OIDC (OpenID Connect) Azonosítás
A CI/CD folyamatok és a Terraform hitelesítése titkosítatlan jelszavak vagy hoszzú életű secret-ek nélkül, OIDC-n keresztül történik az Azure Entra ID (korábban Azure AD) bevonásával.

## Biztonsági szabályok
- **Legkisebb jogosultság (Least Privilege):** A Terraform futtató Service Principal csak a cél Resource Groupokra kap Contributor jogot.
- **Titkosítás (Encryption at rest):** Minden OS disk és Storage Account Azure alapértelmezett CMK/PMK titkosítással rendelkezik.
- **Hálózati izoláció:** Csak a dedikált IP címekről engedélyezett az SSH hozzáférés a gépekhez.
