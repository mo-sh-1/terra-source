
locals {
  pet_map = {
    cat = {
      color = "orange"
      age   = 5
    },
    dog = {
      color = "red"
      age   = 3
    }
  }
}

output "petmap" {
  value = [for i, val in local.pet_map : "${i} is ${val.color} and ${val.age} " if val.age > 3]

}

output "vnetid" {
  value = azurerm_virtual_network.myvnet-new.id

}

output "vnetname" {
  value     = azurerm_virtual_network.myvnet-new.name
  sensitive = true
}


output "subnetid" {
  value = azurerm_subnet.mysubnet.id

}