variable "organization_id" {
  description = "The GCP Organization ID (e.g., 123456789012) where the pool will be created."
  type        = string
}

# variable "project_id" {
#   description = "The GCP project ID where the workforce pool will be created."
#   type        = optional(string)
# }

# variable "saml_metadata_xml_path" {
#   description = "The file path to the Okta SAML metadata.xml file."
#   type        = string
# }

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

# variable "provider_id" {
#   description = "The desired ID for the SAML provider."
#   type        = string
#   default     = "okta-saml-provider"
# }

variable "provider_display_name" {
  description = "The human-readable display name for the SAML provider."
  type        = string
  default     = "Okta SAML Provider"
}

variable "attribute_mapping" {
  description = "A map of SAML assertion attributes to Google attributes."
  type        = map(string)
  default = {
    # Maps the SAML 'NameID' to Google's unique subject
    "google.subject" = "assertion.subject.NameID"
    
    # Maps the SAML attribute for email
    "google.email" = "assertion.attributes['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress']"
    
    # Maps the SAML attribute for groups
    "google.groups" = "assertion.attributes.groups"
    
    # Optional: maps the SAML attribute for display name
    "google.display_name" = "assertion.attributes.displayName"
  }
}

variable "group_iam_bindings" {
  description = "A map where keys are GCP roles (e.g., 'roles/compute.viewer') and values are a list of Okta group names."
  type        = map(list(string))
  default     = {} # Defaults to no bindings
}