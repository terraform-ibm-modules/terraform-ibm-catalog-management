########################################################################################################################
# Input Variables
########################################################################################################################

variable "resource_group_id" {
  type        = string
  description = "Resource group id the catalog is owned by."
}

variable "label" {
  type        = string
  description = "Display name for the catalog."
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

variable "resource_tags" {
  type        = list(string)
  description = "Add user resource tags to the IBM Cloud Catalog instance to organize, track, and manage costs. [Learn more](https://cloud.ibm.com/docs/account?topic=account-tag&interface=ui#tag-types)."
  default     = []
  validation {
    condition     = alltrue([for tag in var.resource_tags : can(regex("^[A-Za-z0-9 _\\-.:](1, 128)$", tag))])
    error_message = "Each resource tag must be 128 characters or less and may contain only A-Z, a-z, 0-9, spaces, underscore (_), hyphen (-), period (.), and colon (:)."
  }
}

variable "disabled" {
  type        = bool
  description = "Denotes whether a catalog is disabled."
  default     = false
}

variable "target_accounts" {
  type = list(object({
    api_key            = optional(string)
    name               = string
    label              = string
    project_id         = optional(string)
    trusted_profile_id = optional(string)
    target_service_id  = optional(string)
  }))
  default     = []
  nullable    = false
  description = "List of target accounts to add to this catalog. Can only be configured on an update, not on a create."

  validation {
    condition = alltrue([
      for target in var.target_accounts : target.api_key != null || target.trusted_profile_id != null || target.project_id != null
    ])
    error_message = "A value is required for either api_key, trusted_profile_id or project_id when adding a target account."
  }

  validation {
    condition = alltrue([
      for target in var.target_accounts : target.project_id != null ? target.api_key != null || target.trusted_profile_id != null : true
    ])
    error_message = "A value is required for either api_key, trusted_profile_id when adding a target account using project_id."
  }

}
