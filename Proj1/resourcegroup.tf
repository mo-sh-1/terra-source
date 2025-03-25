resource "random_string" "random" {
  length  = 5
  upper   = false
  special = false
}

resource "azurerm_resource_group" "p1-rg1" {
  name     = var.rg_name
  location = var.rg_location
}