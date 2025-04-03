########################################################################################################################
# Outputs
########################################################################################################################

output "id" {
  description = "The unique identifier of the catalog."
  value       = ibm_cm_catalog.cm_catalog.id
}

output "crn" {
  description = "CRN associated with the catalog."
  value       = ibm_cm_catalog.cm_catalog.crn
}

output "label" {
  description = "Display Name."
  value       = ibm_cm_catalog.cm_catalog.label
}

output "resource_group_id" {
  description = "Resource group id the catalog is owned by."
  value       = ibm_cm_catalog.cm_catalog.resource_group_id
}

output "catalog_icon_url" {
  description = "The url of the catalog icon."
  value       = ibm_cm_catalog.cm_catalog.catalog_icon_url
}

output "catalog_banner_url" {
  description = " The url of the catalog banner."
  value       = ibm_cm_catalog.cm_catalog.catalog_banner_url
}
