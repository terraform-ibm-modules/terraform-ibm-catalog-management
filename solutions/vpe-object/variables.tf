########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key used to provision resources."
  sensitive   = true
}

# NOTE: provider_visibility not exposed because catalog management resource do not support private endpoints

variable "catalog_id" {
  type        = string
  description = "Catalog identifier."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The programmatic name of this VPE catalog object."
  nullable    = false
  validation {
    condition     = can(regex("^[0-9A-Za-z_]+$", var.name))
    error_message = "Must be upper or lowercase A thru Z, a digit, or (underscore)"
  }
}

variable "label" {
  type        = string
  description = "Display name."
  nullable    = false
}

variable "short_description" {
  type        = string
  description = "Short description."
  default     = null
}

variable "region" {
  type        = string
  description = "The parent region for this specific object."
}

variable "tags" {
  type        = list(string)
  description = "List of tags associated with this object."
  default     = []
}

variable "dns_domain" {
  type        = string
  description = "DNS domain for the VPE to create."
}

variable "endpoint_type" {
  type        = string
  description = "What the VPE exposes, one of api, config, firewall."
  default     = "api"
  validation {
    condition     = contains(["api", "config", "firewall", "vpe"], var.endpoint_type)
    error_message = "Valid values for var: endpoint_type are (api, config, firewall, vpe)."
  }
}

variable "fully_qualified_domain_names" {
  type        = list(string)
  description = "list of FQDNs to map to the VPE object."
  default     = []
}

variable "service_crn" {
  type        = string
  description = "CRN of the service to map on VPE entry and on VPE gateway."

  validation {
    condition = anytrue([
      can(regex("^crn:v\\d:(.*:){2}service:global:::endpoint:[A-Za-z0-9.-]+$", var.service_crn)),
      var.service_crn == null,
    ])
    error_message = "The value provided for 'service_crn' is not valid."
  }
}
