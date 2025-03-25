data "azurerm_client_config" "current" {

}

resource "azurerm_key_vault" "appkeyvault" {
  name                       = "AppKV01"
  location                   = local.loc
  resource_group_name        = local.BRG
  sku_name                   = "standard"
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled   = false
  soft_delete_retention_days = 30
  access_policy {
    tenant_id               = azurerm_user_assigned_identity.AppSS_identity.tenant_id
    object_id               = azurerm_user_assigned_identity.AppSS_identity.principal_id
    certificate_permissions = ["Get", "List"]
    secret_permissions      = ["Get", "List"]
    key_permissions         = ["Get", "List"]
    storage_permissions     = ["Get", "List"]

  }

}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = "VMAdminPWD"
  value        = var.admin_password
  key_vault_id = azurerm_key_vault.appkeyvault.id

}

