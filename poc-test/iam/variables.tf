variable "organization_id" {
  description = "Organization id in organizations/nnnnnn format."
  type        = string
  validation {
    condition     = can(regex("^organizations/[0-9]+", var.organization_id))
    error_message = "The organization_id must in the form organizations/nnn."
  }
}

variable "org_custom_roles" {
  description = "A map where keys are custom role IDs and values are lists of IAM permissions for organization."
  type        = map(list(string))
  default     = {}
}

variable "org_role_assignments_config" {
  description = "A map of custom role IDs to members to be assigned that role."
  type        = map(list(string))
}

variable "project_custom_roles" {
  description = "A map where keys are custom role IDs and values are lists of IAM permissions for organization."
  type        = map(list(string))
  default     = {}
}

variable "project_role_assignments_config" {
  description = "A map of custom role IDs to members to be assigned that role."
  type        = map(list(string))
}