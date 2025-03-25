terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }

    azurerm = {
        source = "hashicorp/azurerm"
      }
  }
}


# OCI Variables.

variable "tenancy_ocid" { type = string }
variable "user_ocid" { type = string }
variable "private_key_path" { type = string }
variable "fingerprint" { type = string }
variable "region" { type = string }
variable "root_compartment_id" { type = string }


# OCI Resources Provider
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  private_key_path = var.private_key_path
  fingerprint      = var.fingerprint
  region           = var.region
}


provider "oci" {
  alias            = "germany"
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  private_key_path = var.private_key_path
  fingerprint      = var.fingerprint
  region           = var.region
}
