variable "vnetname" {
  type = string

}

variable "businessunit" {
  type = string

}

variable "rgname" {
  type = string

}

variable "rglocation" {
  type = string

}

variable "publicipsku" {
  type = map(string)
  default = {
    "germanywestcentral" = "Basic",
    "swedencentral"      = "Standard"
  }

}

