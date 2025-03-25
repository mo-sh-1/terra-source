module "vnet" {
  source  = "Azure/vnet/azurerm"
  version = "5.0.1"
  # insert the 2 required variables here
  vnet_name           = local.vnetname
  resource_group_name = local.rgname
  vnet_location       = local.rglocation
  address_space       = ["10.0.0.0/16"]
  subnet_names        = ["subnet01", "subnet02", "subnet03"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  tags                = local.common_tags


}

resource "azurerm_public_ip" "mod-pip" {
  name                = "pip-${random_string.mod-random.id}"
  location            = local.rglocation
  resource_group_name = local.rgname
  allocation_method   = "Static"
  sku                 = lookup(var.publicipsku, local.rglocation, "Basic")

}

resource "azurerm_network_interface" "mod-nic" {
  location            = local.rglocation
  resource_group_name = local.rgname
  name                = "mod-mic-${random_string.mod-random.id}"
  ip_configuration {
    name                          = "mod-mic-ip-config"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = module.vnet.vnet_subnets_name_id[0]
  }

}

resource "azurerm_network_security_group" "mod-nsg" {
  name                = "mod-nsg-01"
  location            = local.rglocation
  resource_group_name = local.rgname
  security_rule {
    name                       = "ssh_connection"
    protocol                   = "Tcp"
    access                     = "Allow"
    source_port_ranges         = "*"
    destination_port_range     = 22
    priority                   = 100
    direction                  = "Inbound"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Http_Connection"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    priority                   = 110
  }
}

resource "azurerm_subnet_network_security_group_association" "mod-sub-nsg" {
  network_security_group_id = azurerm_network_security_group.mod-nsg.id
  subnet_id                 = module.vnet.vnet_subnets_name_id[0]


}