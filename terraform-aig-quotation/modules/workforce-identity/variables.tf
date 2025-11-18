# --- Control Variable ---
variable "create_pool_only" {
  description = "If true, only creates the Workforce Pool. If false, creates the Provider and IAM bindings."
  type        = bool
}

# --- Pool Variables ---
variable "organization_id" {
  description = "The GCP Organization ID (e.g., 123456789012) where the pool will be created."
  type        = string
  default     = ""
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

# --- Provider/IAM Variables ---
variable "workforce_pool_id" {
  description = "The ID of the pool. Passed from the 'pool' module's output."
  type        = string
  default     = ""
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

variable "attribute_mapping" {
  description = "A map of SAML assertion attributes to Google attributes."
  type        = map(string)
  default     = {}
}

variable "project_id" {
  description = "The GCP project ID where the workforce pool will be created."
  type        = string
  default     = ""
}

variable "saml_metadata_xml_path" {
  description = "The file path to the Okta SAML metadata.xml file."
  type        = string
  default     = ""
}

variable "group_iam_bindings" {
  description = "A map where keys are GCP roles (e.g., 'roles/compute.viewer') and values are a list of Okta group names."
  type        = map(list(string))
  default     = {} # Defaults to no bindings
}