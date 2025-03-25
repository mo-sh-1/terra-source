/*module "ocib" {
  source = "./modules/ocibase"
  providers = {
    ocig.ger = oci.germany
  }
  vcn1     = var.vcn1
  vcn2     = var.vcn2
  req_cidr = var.req_cidr
  subnets  = var.subnets
}*/


data "oci_identity_compartment" "comps_ids" {
  id = var.tenancy_ocid

}

moved {
  from = oci_identity_compartment.get_comp_ids
  to   = oci_identity_compartment.comps_ids
}

locals {
  pet_map = {
    cat = {
      color = "orange"
      age   = 5
    },
    dog = {
      color = "red"
      age   = 3
    }
  }

  pet_type = [for pet_key, pet_value in local.pet_map : " ${pet_key} is ${pet_value.color} and ${pet_value.age} years old " if pet_key == "dog" ]

  my_numbers   = [1, 3, 4, 5, 6, 7, 8, 10, 11, 24, 56]
  even_mumbers = [for i, v in local.my_numbers : i if v % 2 == 0]

}

check "health_check" {
  data "http" "terra_web" {
    #url ="https://www.terraform.io"
    #url ="https://www.tsdfgsdfgdf.io"
    url ="https://www.mohammadsharaf.com"
  }

  assert {
    condition = data.http.terra_web.status_code == 200 
    error_message = "terraform website is not okay"
  }
}

variable "vpc-cidrs"{
  type = set (string)
  default = ["10.0.0.0/24","10.1.0.0/24","10.2.0.0/24"]
}


output "pet_category" {

  value = local.pet_type

}

output "even_nums" {

  value = local.even_mumbers

}


