########################################################################################################################
# Outputs
########################################################################################################################

output "id" {
  description = "The unique identifier of the catalog."
  value       = module.catalog.id
}

output "crn" {
  description = "CRN associated with the catalog."
  value       = module.catalog.crn
}

output "label" {
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
