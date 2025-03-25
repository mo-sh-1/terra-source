data "terraform_remote_state" "project1" {
  backend = "azurerm"
  config = {
    resource_group_name  = "Terraform"
    storage_account_name = "terrastatefile0001"
    container_name       = "terra-state-file-host"
    key                  = "p1-state-file-01.tfstate"
  }

}