#variable "region" { type = string }
#variable "comp1_id" { type = string }
#variable "comp2_id" { type = string }
variable "compartments_names" {
  type = map(any)
  default = {
    "comp001" = "Compartment1"
    "comp002" = "Compartment2"

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

variable "subnets" {
  description = "list of values to assign to subnets"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}

variable "map-type" {
  type = map(string)
  default = {
    key1 = 10
    key2 = 20
    key3 = 30
  }
}


variable "refe-obj-count" {
  type = list(object({
    name    = string
    age     = number
    output  = bool
    address = string
  }))
  default = [{ name = "Najwa", age = 27, output = true, address = "Vienna" }]
}

variable "refe_ob_fe" {
  type = map(object({
    name   = string
    age    = number
    output = bool
  }))
  default = {
    "obj1" = {
      name   = "Mohammad",
      age    = 36,
      output = true
    },
    "obj2" = {
      name   = "Ahmad",
      age    = 30,
      output = false
    }
  }
}