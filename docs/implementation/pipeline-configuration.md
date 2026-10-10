# CI/CD Pipeline Konfiguráció

A projekt támogatja az automatizált build-et Azure DevOps vagy GitHub Actions segítségével.

- Az azonosítás **OIDC Federation** alapú.
- **PR ellenőrzés (CI):** `terraform fmt -check`, `terraform validate`, `terraform plan`.
- **Merge végrehajtás (CD):** `terraform apply -auto-approve`.
