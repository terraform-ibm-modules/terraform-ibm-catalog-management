########################################################################################################################
# Outputs
########################################################################################################################

output "id" {
  description = "The unique identifier of the object."
  value       = module.vpe_object.id
}

output "crn" {
  description = "CRN associated with the object."
  value       = module.vpe_object.crn
}

output "label" {
  description = "Display Name."
  value       = module.vpe_object.label
}

output "name" {
  description = "The programmatic name of this object"
  value       = module.vpe_object.name
}

output "url" {
  description = "The url for this specific object."
  value       = module.vpe_object.url
}

output "publish" {
  description = "Publish information."
  value       = module.vpe_object.publish
}
