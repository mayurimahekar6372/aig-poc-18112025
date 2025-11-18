variable "custom_roles" {
  description = "A map where keys are custom role IDs and values are a list of predefined roles to inherit permissions from."
  type        = map(list(string))
  default     = {}
}

variable "service_accounts" {
  description = "A map of service account IDs to create. Key is the SA ID, value is the display name."
  type        = map(string)
}

variable "sa_role_bindings" {
  description = "Map of custom role IDs to a list of service account IDs that should receive that role."
  # This is a map where values are lists of strings.
  type    = map(list(string))
  default = {}
}

variable "project_id" {
  description = "The ID of the project where the custom roles will be created."
  type        = string
}

variable "excluded_permissions" {
  description = "List of permissions to exclude from the final custom role, overriding the default exclusions."
  type        = list(string)
  default     = []
}

variable "default_excluded_permissions" {
  description = "A standard list of IAM permissions that are invalid for project-level custom roles."
  type        = list(string)
  default = [
    "resourcemanager.projects.list",
    "resourcemanager.projects.get",
    "resourcemanager.folders.list",
    "resourcemanager.folders.get",
    "resourcemanager.organizations.list",
    "resourcemanager.organizations.get",
    # Add other known organization-level permissions as needed
    "billing.accounts.get",
  ]
}