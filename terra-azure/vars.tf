variable "rglist" {
  type    = string
  default = "Terr-RG-01"

}

variable "rglocation" {
  type = string
  validation {
    #condition = var.rglocation == "germanywestcentral" || var.rglocation == "eastus"
    #condition = contains (["eastus","germanywestcentral"],lower(var.rglocation))
    condition     = can(regex("central$", var.rglocation))
    error_message = "only GermanyWestCentral & EastUS regions are allowed to host resources"
  }

}
variable "vmlist" {
  type = list(string)

}

variable "vnetlist" {
  type = list(string)

}

variable "subnetlist" {
  type = list(string)

}

variable "publicipsku" {
  type = map(string)
  default = {
    "germanywestcentral" = "Standard",
    "swedencentral"      = "Basic"

  }

}

variable "adminsshkey" {
  sensitive = true
  type      = string
  default   = "C:\\Users\\Mohammad\\Documents\\Terraform\\terra-azure\\ssh\\general-use.pub"

}


variable "objvar" {
  type = object({
    att1 = string
    att2 = number
  })

}

variable "listobj" {
  type = list(object({
    lobj1 = string
    lobj2 = bool
    lobj3 = list(string)
    })
  )

}


variable "mapobj" {
  type = map(object({
    mobj1 = string,
    mobj2 = bool,
    mobj3 = list(string)
    })
  )

}

variable "tupleobj" {
  type = tuple([object({
    tobj1 = string
    tobi2 = bool
    tobj3 = number
  }), string, bool])

}