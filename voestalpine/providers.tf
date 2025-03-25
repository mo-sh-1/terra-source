terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  backend "azurerm" {
    resource_group_name  = "Terraform"
    storage_account_name = "terrastatefile0001"
    container_name       = "terra-state-file-host"
    key                  = "voestalpine-project.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "39edb0d2-9644-44ec-b6ba-d7121aab3fdf"
  tenant_id       = "d5df16cd-2d3a-4d58-8a75-925f5b5824ce"
  client_id       = "852f2408-0502-4cfc-8dda-2a60f6f24ace"
  client_secret   = "J_x8Q~ROe10B8b1I6gYZiSmEwAGg416jQhyYEchn"
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}