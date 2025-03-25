locals {
  service_owner = "Mohammad"
  OS_Type       = "Linux"
  device_type   = "Laptop"
  common_tags = {
    owner  = local.service_owner == "Moh" ? local.service_owner : "unrecognized-owner"
    OS     = local.OS_Type == "Linux" ? local.OS_Type : "Windows"
    device = local.device_type
  }
}