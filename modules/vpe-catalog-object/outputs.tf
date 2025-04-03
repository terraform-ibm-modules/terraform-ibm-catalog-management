########################################################################################################################
# Outputs
########################################################################################################################

output "id" {
  description = "The unique identifier of the object."
  value       = ibm_cm_object.cm_object.id
}

output "crn" {
  description = "CRN associated with the object."
  value       = ibm_cm_object.cm_object.crn
}

output "label" {
  description = "Display Name."
  value       = ibm_cm_object.cm_object.label
}

output "name" {
  description = "The programmatic name of this object"
  value       = ibm_cm_object.cm_object.name
}

output "url" {
  description = "The url for this specific object."
  value       = ibm_cm_object.cm_object.url
}

output "publish" {
  description = "Publish information."
  value       = ibm_cm_object.cm_object.publish
}
