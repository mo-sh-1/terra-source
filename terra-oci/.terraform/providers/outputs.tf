output "VCN_ID" {
	description = "OCID of created VCN."
	value = oci_core_vcn.internal.id
}
