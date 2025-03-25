
variable "compartments_names" {
  #type    = list(string)
  default = {
        "D1" = "Compartment1",
        "D2" = "Compartment2"
        }
}


variable "vcn1" {
  type = string
}


variable "vcn2" {
  type = string
}

variable "req_cidr" {
  type = list(string)
}

variable "tagin" {
  type = string
  default = "test1"
}

variable "tags-vales" {
  type = map
  default = {
    Owner = "Mohammad",
    Created = "2024-Aug"
  }
}

variable "subnets" {
  description = "list of values to assign to subnets"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}