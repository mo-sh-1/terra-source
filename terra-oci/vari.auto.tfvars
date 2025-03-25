region = "eu-zurich-1"
#comp1_id = oci_identity_compartment.TerraForEach_Compartments["comp1"].id
#comp2_id = oci_identity_compartment.TerraForEach_Compartments["comp2"].id

vcn1 = "10.0.0.0/16"
vcn2 = "10.1.0.0/16"

req_cidr = ["10.10.0.0/16"] #, "10.1.0.0/16"

subnets = [
  { name = "snet1", address_prefix = "10.10.1.0/24" },
  { name = "snet2", address_prefix = "10.10.2.0/24" },
  { name = "snet3", address_prefix = "10.10.3.0/24" },
  { name = "snet4", address_prefix = "10.10.4.0/24" }
]
