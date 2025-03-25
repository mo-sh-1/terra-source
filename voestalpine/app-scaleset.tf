resource "azurerm_windows_virtual_machine_scale_set" "AppScaleSet" {
  name                 = local.VMSS
  resource_group_name  = local.BRG
  location             = local.loc
  instances            = 3
  computer_name_prefix = "App01-VM-"
  sku                  = "Standard_F2"
  admin_username       = "Voestalpine-admin"
  admin_password       = local.adminpwd


  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter-Server-Core"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Premium_ZRS"
    caching              = "ReadWrite"

  }

  data_disk {
    caching              = "ReadWrite"
    lun                  = 0
    storage_account_type = "Premium_ZRS"
    disk_size_gb         = 1024

  }
  network_interface {
    name    = "App-nic-01"
    primary = true
    ip_configuration {
      name                                         = "app-ip-config-01"
      subnet_id                                    = azurerm_subnet.AppSubnet.id
      application_gateway_backend_address_pool_ids = azurerm_application_gateway.APPGateway-01.backend_address_pool[*].id
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.AppSS_identity.id]
  }

}

resource "azurerm_user_assigned_identity" "AppSS_identity" {
  name                = "vmss-identity"
  resource_group_name = local.FRG
  location            = local.loc

}

