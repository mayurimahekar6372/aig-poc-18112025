# -----------------------------------------------------------------------------
# INPUT VARIABLES
# -----------------------------------------------------------------------------

variable "organization_id" {
  type        = string
  description = "The ID of the Google Cloud organization (e.g., '123456789012')."
}

variable "billing_project" {
  type        = string
  description = "A project ID to use for billing provider operations."
}

variable "custom_roles" {
  type        = map(list(string))
  description = "A map where keys are the custom role IDs and values are lists of predefined GCP roles to include."
  default     = {}
}

variable "custom_role_bindings" {
  description = "A map where the key is the custom role_id and the value is a list of members (users/groups) to be bound to that role."
  type        = map(list(string))
  default     = {}
}

variable "excluded_permissions" {
  description = "List of permissions to exclude from the final custom role, overriding the default exclusions."
  type        = list(string)
  default     = []
}

variable "default_excluded_permissions" {
  description = "A standard list of IAM permissions that are invalid for project-level custom roles."
  type        = list(string)
  default     = []
}