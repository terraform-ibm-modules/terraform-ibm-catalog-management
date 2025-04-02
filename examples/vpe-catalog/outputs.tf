########################################################################################################################
# Outputs
########################################################################################################################

output "catalog_id" {
  description = "The unique identifier of the catalog."
  value       = module.catalog.id
}

output "catalog_crn" {
  description = "CRN associated with the catalog."
  value       = module.catalog.crn
}

output "catalog_label" {
  description = "Display Name."
  value       = module.catalog.label
}

output "resource_group_name" {
  description = "Resource group name."
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "Resource group ID."
  value       = module.resource_group.resource_group_id
}

output "object_id" {
  description = "The unique identifier of the object."
  value       = module.vpe_object.id
}

output "object_crn" {
  description = "CRN associated with the object."
  value       = module.vpe_object.crn
}

output "object_label" {
  description = "Display Name."
  value       = module.vpe_object.label
}

output "object_name" {
  description = "The programmatic name of this object"
  value       = module.vpe_object.name
}

output "object_url" {
  description = "The url for this specific object."
  value       = module.vpe_object.url
}

output "object_publish_info" {
  description = "Publish information."
  value       = module.vpe_object.publish
}
