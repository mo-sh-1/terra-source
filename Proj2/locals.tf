locals {
  rgname   = "${var.rg-name}_${terraform.workspace}"
  vnetname = "${var.vnet-name}_${terraform.workspace}"
  owner    = "P1-Mohammad"
  type     = "P1-global admin"
  common_tags = {
    owner     = "P1-Mhd Sharaf"
    type      = "P1-GAdmin"
    worksapce = terraform.workspace
  }

}