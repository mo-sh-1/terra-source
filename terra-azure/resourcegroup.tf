resource "random_string" "myrandom" {
  length  = 6
  special = false
  upper   = false

}

resource "azurerm_resource_group" "myrg01" {
  name     = var.rglist
  location = var.rglocation
  provider = azurerm.northeu

}

resource "azurerm_resource_group" "myrg02" {
  name     = "${var.rglist}-${random_string.myrandom.id}"
  location = var.rglocation

}
/*
resource "azurerm_resource_group" "imp-rg" {

}*/