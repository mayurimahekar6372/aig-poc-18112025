variable "organization_id" {
  description = "Organization id in organizations/nnnnnn format."
  type        = string
  validation {
    condition     = can(regex("^organizations/[0-9]+", var.organization_id))
    error_message = "The organization_id must in the form organizations/nnn."
  }
  default = ""
}

variable "pool_id" {
  description = "The desired ID for the workforce pool."
  type        = string
  default     = "okta-saml-pool"
}

variable "pool_display_name" {
  description = "The human-readable display name for the workforce pool."
  type        = string
  default     = "Okta SAML Pool"
}

variable "provider_id" {
  description = "The desired ID for the SAML provider."
  type        = string
  default     = ""
}

variable "provider_display_name" {
  description = "The human-readable display name for the SAML provider."
  type        = string
  default     = ""
}

variable "okta_metadata_file" {
  description = "File path to the Okta metadata.xml file."
  type        = string
  default     = "okta-metadata.xml"
}

variable "okta_group_permissions" {
  description = "Map of GCP Roles to Okta group names."
  type        = map(list(string))
  default     = {}
}

variable "attribute_mapping" {
  description = "A map of SAML assertion attributes to Google attributes."
  type        = map(string)
  default     = {}
}
