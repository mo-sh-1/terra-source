
resource "oci_identity_compartment" "TerraForEach_Compartments" {
  provider = ocig
  for_each    = tomap(var.compartments_names)
  name        = each.key
  description = "create staging and dev compartments"
}


resource "oci_identity_compartment" "TC_Comps" {
  count       = length(var.req_cidr)
  provider    = ocig
  name        = "CT_${count.index}"
  description = " create compartment using count meta-argument"
  freeform_tags = var.tags-vales

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [freeform_tags, name]
  }

}

moved {
  from = oci_identity_compartment.TerraCount_Compartments
  to = oci_identity_compartment.TC_Comps
}

resource "oci_core_vcn" "internal" {
  count = length(var.req_cidr)
  provider = ocig
  dns_label  = "internal"
  cidr_block = var.req_cidr[count.index]
  compartment_id = oci_identity_compartment.TerraForEach_Compartments["D1"].id
  display_name   = "OCI-VCN-${count.index}"

  timeouts {
    create = "10m"
    update = "30m"
    delete = "30m"
  }
/*
  dynamic "subnet" {
    for_each = var.subnets
    iterator = item   #optional
    content {
      compartment_id = oci_core_vcn.internal[count.index].compartment_id
      vcn_id = oci_core_vcn.internal[count.index].id
      cidr_block = sub.value.prefix
      }
  }*/
}

/*
resource "oci_core_vcn" "internal2" {
  provider = ocig
  dns_label  = "internal2"
  cidr_block = var.vcn2
  #compartment_id = var.comp1_id
  compartment_id = oci_identity_compartment.TerraForEach_Compartments["comp2"].id
  display_name   = "OCI-VCN-02"

  timeouts {
    create = "10m"
    update = "30m"
    delete = "30m"
  }

}



*/
resource "oci_core_subnet" "vcn1_subx" {
  count = length(var.req_cidr)
  provider = ocig
  cidr_block = cidrsubnet(oci_core_vcn.internal[count.index].cidr_block,8,4)
  compartment_id = oci_core_vcn.internal[count.index].compartment_id
  vcn_id = oci_core_vcn.internal[count.index].id
  #display_name = "${oci_core_vcn.internal.display_name}_sub_${count.index}"
  display_name = "${oci_core_vcn.internal[count.index].display_name}-Sub-${count.index}"
  #display_name = "sub_${each.key}"

}


