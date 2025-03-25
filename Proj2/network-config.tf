resource "azurerm_virtual_network" "p2vnet" {
  name                = local.vnetname
  resource_group_name = data.terraform_remote_state.project1.outputs.rgname
  location            = data.terraform_remote_state.project1.outputs.rglocation
  address_space       = ["10.1.0.0/16"]
  tags                = local.common_tags
  lifecycle {
    ignore_changes = [tags, ]
  }

}