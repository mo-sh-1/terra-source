  resource "azurerm_virtual_network" "APPGWVCN" {
    name                = "VCN01"
    resource_group_name = local.FRG
    address_space       = ["10.1.0.0/16"]
    location            = local.loc

  }

  resource "azurerm_subnet" "APPGWSubnet" {
    name                 = "WAFSub-01"
    address_prefixes     = ["10.1.0.0/27"]
    resource_group_name  = local.FRG
    virtual_network_name = azurerm_virtual_network.APPGWVCN.name

  }

  resource "azurerm_virtual_network" "FWVCN" {
    name                = "VCN02"
    resource_group_name = local.FRG
    address_space       = ["10.2.0.0/16"]
    location            = local.loc

  }

  resource "azurerm_subnet" "FWSubnet" {
    name                 = "AzureFirewallSubnet"
    address_prefixes     = ["10.2.0.0/26"]
    resource_group_name  = local.FRG
    virtual_network_name = azurerm_virtual_network.FWVCN.name

  }

  resource "azurerm_virtual_network" "AppVCN" {
    name                = "VCN03"
    resource_group_name = local.BRG
    address_space       = ["10.3.0.0/16"]
    location            = local.loc

  }

  resource "azurerm_subnet" "AppSubnet" {
    name                 = "AppSub-01"
    address_prefixes     = ["10.3.0.0/27"]
    resource_group_name  = local.BRG
    virtual_network_name = azurerm_virtual_network.AppVCN.name

  }

  resource "azurerm_virtual_network" "SQLVCN" {
    name                = "VCN04"
    resource_group_name = local.BRG
    address_space       = ["10.4.0.0/16"]
    location            = local.loc

  }

  resource "azurerm_subnet" "SQLSubnet" {
    name                 = "SQLSub-01"
    address_prefixes     = ["10.4.0.0/27"]
    resource_group_name  = local.BRG
    virtual_network_name = azurerm_virtual_network.SQLVCN.name

  }

  resource "azurerm_public_ip" "FWPIP" {
    name                = "firewallpip"
    allocation_method   = "Static"
    resource_group_name = local.FRG
    location            = local.loc
    sku                 = "Standard"

  }
  resource "azurerm_firewall" "internalfirewall" {
    name                = "appfirewall-01"
    resource_group_name = local.FRG
    location            = local.loc
    sku_name            = "AZFW_VNet"
    sku_tier            = "Standard"
    ip_configuration {
      name                 = "FWIPConfig"
      subnet_id            = azurerm_subnet.FWSubnet.id
      public_ip_address_id = azurerm_public_ip.FWPIP.id
    }
  }