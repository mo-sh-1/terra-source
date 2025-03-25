resource "random_string" "mod-random" {
  length  = 5
  upper   = false
  special = false

}

resource "azurerm_resource_group" "Mod-Rgs" {
  name     = local.rgname
  location = local.rglocation

}