########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API key used to provision resources."
  sensitive   = true
}

# NOTE: provider_visibility not exposed because catalog management resource do not support private endpoints

variable "existing_resource_group_name" {
  type        = string
  description = "The name of an existing resource group to provision resource in."
  default     = "Default"
  nullable    = false
}

variable "label" {
  type        = string
  description = "Display name for the catalog. "
  nullable    = false
}

variable "short_description" {
  type        = string
  description = "A description of the catalog."
  default     = null
}

variable "kind" {
  type        = string
  description = "Kind of catalog. Supported kinds are 'offering' and 'vpe'."
  default     = "offering"
  validation {
    condition     = contains(["offering", "vpe"], var.kind)
    error_message = "The specified kind is invalid. Supported kinds are 'offering' and 'vpe'."
  }
  nullable = false
}

variable "catalog_icon_url" {
  type        = string
  description = "URL for an icon associated with this catalog."
  default     = null
}

variable "catalog_banner_url" {
  type        = string
  description = "URL for a banner image for this catalog."
  default     = null
}

variable "tags" {
  type        = list(string)
  description = "List of tags associated with this catalog."
  default     = []
}

variable "disabled" {
  type        = bool
  description = "Denotes whether a catalog is disabled."
  default     = false
}
