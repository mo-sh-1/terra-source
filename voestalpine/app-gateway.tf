resource "azurerm_public_ip" "APPGWPIP" {
  name                = "appgwpip"
  allocation_method   = "Static"
  resource_group_name = local.FRG
  location            = local.loc
  sku                 = "Standard"

}

resource "azurerm_application_gateway" "APPGateway-01" {
  name                = "AppGW01"
  resource_group_name = local.FRG
  location            = local.loc
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "App-private-ip-config"
    subnet_id = azurerm_subnet.APPGWSubnet.id

  }

  frontend_port {
    name = local.frontend_port_name
    port = 80

  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.APPGWPIP.id

  }
  autoscale_configuration {
    min_capacity = 0
    max_capacity = 2
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "AppGWRoutingRule-01"
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }


}