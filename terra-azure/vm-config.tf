resource "azurerm_linux_virtual_machine" "VMs" {
  #count = 2
  for_each              = azurerm_network_interface.mynic
  name                  = "terrvm-${each.key}"
  computer_name         = "osterrvm-${each.key}"
  location              = azurerm_resource_group.myrg02.location
  network_interface_ids = [azurerm_network_interface.mynic[each.key].id]
  resource_group_name   = azurerm_resource_group.myrg02.name
  size                  = "Standard_B1s"
  admin_username        = "azureuser"

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    name                 = "linux-os-disk-${each.key}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"

  }

  admin_ssh_key {
    public_key = file(var.adminsshkey)
    username   = "azureuser"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = filebase64("${path.module}\\app1-cloud-init.txt")

  connection {
    host        = self.public_ip_address
    type        = "ssh"
    user        = self.admin_username
    private_key = file("${path.module}\\ssh\\general-use-openssh.pem")
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir /home/${self.admin_username}/tmp",
    "sudo chown -R ${self.admin_username}:${self.admin_username} /home/${self.admin_username}/tmp"]


  }

  provisioner "file" {
    source      = "C:\\Users\\Mohammad\\Documents\\Terraform\\terra-azure\\apps\\app2\\app2.html"
    destination = "/home/${self.admin_username}/tmp/app2.html"
    #on_failure = continue

  }

  provisioner "remote-exec" {
    inline = ["sudo cp /home/${self.admin_username}/tmp/app2.html /var/www/html/app1"]

  }

  provisioner "file" {
    content     = "VM Host Name is ${self.computer_name}"
    destination = "/home/${self.admin_username}/tmp/file.log"
    #on_failure = continue
    #when = destroy

  }

  provisioner "file" {
    source      = "C:\\Users\\Mohammad\\Documents\\Terraform\\terra-azure\\apps\\app1"
    destination = "/home/${self.admin_username}/tmp"
    #on_failure = continue
  }

  provisioner "file" {
    source      = "C:\\Users\\Mohammad\\Documents\\Terraform\\terra-azure\\apps\\app1\\"
    destination = self.admin_username
    #on_failure = continue

  }

  provisioner "local-exec" {
    command = "echo on creare local-file provisioner >> on-create.txt"
  }

  provisioner "local-exec" {
    command = "echo on destroy local-file provisioner >> on-destroy.txt"
    when    = destroy
  }


}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "vmoff" {
  #count = 2
  for_each              = azurerm_linux_virtual_machine.VMs
  virtual_machine_id    = azurerm_linux_virtual_machine.VMs[each.key].id
  timezone              = "W. Europe Standard Time"
  location              = azurerm_resource_group.myrg02.location
  daily_recurrence_time = 1900
  enabled               = true
  notification_settings {
    enabled = false
  }

}