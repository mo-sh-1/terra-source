resource "azurerm_mssql_server" "sqlserver-01" {
  name                         = "sqlserver01"
  resource_group_name          = local.BRG
  location                     = local.loc
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = local.adminpwd
  minimum_tls_version          = "1.2"

}

resource "azurerm_mssql_database" "mssql01" {
  name                        = var.mssql
  server_id                   = azurerm_mssql_server.sqlserver-01.id
  auto_pause_delay_in_minutes = 30
  sku_name                    = "S0"
  license_type                = "BasePrice"
  geo_backup_enabled          = true
  zone_redundant              = true
  storage_account_type        = "GeoZone"
  lifecycle {
    prevent_destroy = true
  }

}