locals {
  vnetname       = "${var.businessunit}-${var.vnetname}-${random_string.mod-random.id}"
  rgname         = "${var.businessunit}-${var.rgname}-${random_string.mod-random.id}"
  rglocation     = var.rglocation
  resource_owner = "Mohammad"
  common_tags = {
    service_owner = "Mohammad"
    type          = "GAdmin"
  }
}