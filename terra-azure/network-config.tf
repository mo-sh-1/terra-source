

resource "azurerm_virtual_network" "myvnet-new" {
  #for_each = toset(var.vmlist)
  name                = var.vnetlist[0]
  resource_group_name = azurerm_resource_group.myrg02.name
  location            = azurerm_resource_group.myrg02.location
  address_space       = ["10.1.0.0/16"]
  tags                = local.common_tags
  lifecycle {
    ignore_changes = [tags, ]
  }

}

resource "azurerm_subnet" "mysubnet" {
  #for_each = azurerm_virtual_network.myvnet-new.address_space
  name                 = var.subnetlist[0]
  address_prefixes     = ["10.1.0.0/27"]
  virtual_network_name = azurerm_virtual_network.myvnet-new.name
  resource_group_name  = azurerm_resource_group.myrg02.name

}

resource "azurerm_public_ip" "mypip" {
  #count = 2
  for_each = toset(var.vmlist)
  name     = "${each.value}-PIP"
  location = azurerm_resource_group.myrg02.location
  #resource_group_name = azurerm_resource_group.myrg02.name
  resource_group_name = data.azurerm_resource_group.ergs.name
  allocation_method   = "Static"
  domain_name_label   = "terr-app1-${each.key}-${random_string.myrandom.id}"
  sku                 = lookup(var.publicipsku, azurerm_resource_group.myrg01.location, "Basic")
  tags                = local.common_tags

}

resource "azurerm_network_interface" "mynic" {
  #count = 2
  for_each            = toset(var.vmlist)
  name                = "${each.value}-nic"
  location            = azurerm_resource_group.myrg02.location
  resource_group_name = azurerm_resource_group.myrg02.name

  ip_configuration {
    name                          = "ip-config-nic-${each.key}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypip[each.key].id
    subnet_id                     = azurerm_subnet.mysubnet.id
  }

}

resource "azurerm_network_security_group" "nsg" {
  name                = "terr-nsg-01"
  location            = azurerm_resource_group.myrg02.location
  resource_group_name = azurerm_resource_group.myrg02.name

  security_rule {
    name                       = "ssh-access"
    protocol                   = "Tcp"
    access                     = "Allow"
    priority                   = 100
    direction                  = "Inbound"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }

  security_rule {
    name                       = "http-access"
    protocol                   = "Tcp"
    access                     = "Allow"
    priority                   = 200
    direction                  = "Inbound"
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg" {
  subnet_id                 = azurerm_subnet.mysubnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}



