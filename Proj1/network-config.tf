resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet-name
  address_space       = ["10.0.0.0/16"]
  location            = var.rg_location
  resource_group_name = azurerm_resource_group.p1-rg1.name
  /*tags = {
    owner = local.owner
  }*/
  tags = local.common_tags
  lifecycle {
    #prevent_destroy = true
    ignore_changes = [tags, ]
  }

}