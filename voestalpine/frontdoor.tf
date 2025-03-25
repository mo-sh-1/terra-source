resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  name                = var.frontdoor
  resource_group_name = local.FRG
  sku_name            = "Premium_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_origin_group" "fd_origin_group" {
  name                     = "appgw-origin-group"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
  session_affinity_enabled = false

  health_probe {
    protocol            = "Https"
    request_type        = "HEAD"
    interval_in_seconds = 30
    path                = "/health" # Ensure App Gateway serves this path
  }

  load_balancing {
    additional_latency_in_milliseconds = 0
    successful_samples_required        = 3
    sample_size                        = 4
  }

}

resource "azurerm_cdn_frontdoor_origin" "fd_origin" {
  name                           = "appgw-origin"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.fd_origin_group.id
  enabled                        = true
  certificate_name_check_enabled = false

  host_name          = azurerm_public_ip.APPGWPIP.ip_address
  http_port          = 80
  https_port         = 443
  origin_host_header = azurerm_public_ip.APPGWPIP.ip_address
  priority           = 1
  weight             = 1000
}

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  name                     = "myafendpoint"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile.id
}

