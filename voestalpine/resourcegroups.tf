resource "random_string" "random" {
  length  = 5
  upper   = false
  special = false

}
resource "azurerm_resource_group" "frontRGS" {
  name     = local.FRG
  location = local.loc

}

resource "azurerm_resource_group" "backRGS" {
  name     = local.BRG
  location = local.loc

}

resource "azurerm_resource_group" "bkpRGS" {
  name     = local.BKP
  location = local.loc

}