resource "azurerm_storage_account" "nc_storage_account" {
  name                     = var.nc_storage_account_name
  resource_group_name      = var.nc_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_share" "nc_data_share" {
  name                 = "nc-data-share"
  storage_account_name = azurerm_storage_account.nc_storage_account.name
  quota                = 50
}

resource "azurerm_storage_share" "nc_db_share" {
  name                 = "nc-db-share"
  storage_account_name = azurerm_storage_account.nc_storage_account.name
  quota                = 10
}

resource "azurerm_log_analytics_workspace" "nc_law" {
  name                = "nc-law"
  location            = var.location
  resource_group_name = var.nc_resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_container_app_environment" "nc_aca_env" {
  name                       = "nc-env"
  location                   = var.location
  resource_group_name        = var.nc_resource_group_name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.nc_law.id
  tags                       = var.tags
}

resource "azurerm_container_app_environment_storage" "nc_db_storage" {
  name                         = "ncdbstore"
  container_app_environment_id = azurerm_container_app_environment.nc_aca_env.id
  account_name                 = azurerm_storage_account.nc_storage_account.name
  share_name                   = azurerm_storage_share.nc_db_share.name
  access_key                   = azurerm_storage_account.nc_storage_account.primary_access_key
  access_mode                  = "ReadWrite"
}

resource "azurerm_container_app_environment_storage" "nc_data_storage" {
  name                         = "ncdatastore"
  container_app_environment_id = azurerm_container_app_environment.nc_aca_env.id
  account_name                 = azurerm_storage_account.nc_storage_account.name
  share_name                   = azurerm_storage_share.nc_data_share.name
  access_key                   = azurerm_storage_account.nc_storage_account.primary_access_key
  access_mode                  = "ReadWrite"
}

resource "random_password" "nc_db_root_password" {
  length  = 20
  special = true
}

resource "random_password" "nc_db_password" {
  length  = 20
  special = true
}

resource "azurerm_container_app" "nc_mariadb_container" {
  name                         = "nc-mariadb"
  container_app_environment_id = azurerm_container_app_environment.nc_aca_env.id
  resource_group_name          = var.nc_resource_group_name
  revision_mode                = "Single"
  tags                         = var.tags

  secret {
    name  = "mysql-root-password"
    value = random_password.nc_db_root_password.result
  }
  secret {
    name  = "mysql-password"
    value = random_password.nc_db_password.result
  }

  template {
    min_replicas = 1
    max_replicas = 1

    volume {
      name         = "db-data"
      storage_type = "EmptyDir"
    }

    container {
      name   = "mariadb"
      image  = "mariadb:10.6"
      cpu    = 0.5
      memory = "1.0Gi"

      env {
        name        = "MYSQL_ROOT_PASSWORD"
        secret_name = "mysql-root-password"
      }
      env {
        name  = "MYSQL_DATABASE"
        value = "nextcloud"
      }
      env {
        name  = "MYSQL_USER"
        value = "nextcloud"
      }
      env {
        name        = "MYSQL_PASSWORD"
        secret_name = "mysql-password"
      }

      volume_mounts {
        name = "db-data"
        path = "/var/lib/mysql"
      }
    }
  }

  ingress {
    allow_insecure_connections = false
    external_enabled           = false
    target_port                = 3306
    transport                  = "tcp"
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}

resource "azurerm_container_app" "nc_nextcloud_container" {
  name                         = "bb-nextcloud"
  container_app_environment_id = azurerm_container_app_environment.nc_aca_env.id
  resource_group_name          = var.nc_resource_group_name
  revision_mode                = "Single"
  tags                         = var.tags

  secret {
    name  = "mysql-password"
    value = random_password.nc_db_password.result
  }

  template {
    min_replicas = 0
    max_replicas = 1

    volume {
      name         = "nc-data"
      storage_name = azurerm_container_app_environment_storage.nc_data_storage.name
      storage_type = "AzureFile"
    }

    container {
      name   = "nextcloud"
      image  = "nextcloud:latest"
      cpu    = 0.5
      memory = "1.0Gi"

      env {
        name  = "MYSQL_HOST"
        value = "${azurerm_container_app.nc_mariadb_container.ingress[0].fqdn}:3306"
      }
      env {
        name  = "MYSQL_DATABASE"
        value = "nextcloud"
      }
      env {
        name  = "MYSQL_USER"
        value = "nextcloud"
      }
      env {
        name        = "MYSQL_PASSWORD"
        secret_name = "mysql-password"
      }

      volume_mounts {
        name = "nc-data"
        path = "/var/www/html/data"
      }
    }
  }

  ingress {
    allow_insecure_connections = true
    external_enabled           = true
    target_port                = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
