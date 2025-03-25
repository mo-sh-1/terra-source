locals {

  #values related to the resource groups and location
  FRG      = var.frontrg
  loc      = var.location
  BRG      = var.backrg
  BKP      = var.bkprg
  VMSS     = var.appname
  adminpwd = var.admin_password

  #values related to the application gateway 
  backend_address_pool_name      = "${azurerm_virtual_network.APPGWVCN.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.APPGWVCN.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.APPGWVCN.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.APPGWVCN.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.APPGWVCN.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.APPGWVCN.name}-rqrt"
  redirect_configuration_name    = "${azurerm_virtual_network.APPGWVCN.name}-rdrcfg"
  tenantid                       = "d5df16cd-2d3a-4d58-8a75-925f5b5824ce"

}