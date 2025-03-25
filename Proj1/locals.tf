locals {
  owner = "Mohammad"
  type  = "global admin"
  common_tags = {
    owner     = "Mhd Sharaf"
    type      = "GAdmin"
    worksapce = terraform.workspace
  }

}
