# variable "gcp_project_id" {
#   description = "The GCP project ID to deploy all resources."
#   type        = optional(string)
# }

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

variable "organization_id" {
  description = "Organization id in organizations/nnnnnn format."
  type        = string
#   validation {
#     condition     = can(regex("^organizations/[0-9]+", var.organization_id))
#     error_message = "The organization_id must in the form organizations/nnn."
#   }
}