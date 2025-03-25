resource "random_string" "random" {
  length  = 5
  upper   = false
  special = false

}

resource "azurerm_resource_group" "p2-rg2" {
  name     = local.rgname
  location = var.rg-location

}