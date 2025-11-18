# variables.tf

variable "organization_id" {
  description = "The ID of the GCP Organization (e.g., 123456789012)."
  type        = string
}

# variable "project_id" {
#   description = "The ID of the GCP project where the Service Account will be created."
#   type        = string
# }

# Service Account Variables

# variable "sa_account_id" {
#   description = "The ID of the service account to create."
#   type        = string
# }

# variable "sa_display_name" {
#   description = "A human-readable name for the service account."
#   type        = string
#   default     = "Terraform Managed Service Account"
# }

# Custom Role Variables (using your map structure for a single custom role)

variable "service_custom_roles" {
  description = "A map where the key is the custom role ID and the value is a list of permissions."
  type        = map(list(string))
  # Example Expected Structure:
  # {
  #   "CloudCoreReader" = ["compute.instances.list", "storage.buckets.get"]
  # }
  # The module assumes only a single role will be defined in this map.
}

# variable "role_title" {
#   description = "A human-readable title for the custom role."
#   type        = string
# }

# variable "role_description" {
#   description = "A description for the custom role."
#   type        = string
#   default     = "Organization Custom Role created by Terraform module"
# }

# variable "custom_role_bindings" {

# }

# -----------------------------------------------------------------------------
# VARIABLES (ASSUMED)
# -----------------------------------------------------------------------------

# variable "project_id" {
#   description = "The ID of the project where the service accounts will be created."
#   type        = string
# }

variable "service_accounts" {
  description = "A map of service account IDs to create. Key is the SA ID, value is the display name."
  type        = map(string)
  default = {
    "my-data-reader-sa"    = "Data Reader Service Account"
    "my-backend-writer-sa" = "Backend Writer Service Account"
  }
}

variable "sa_role_bindings" {
  description = "A map defining which custom role to assign to which service account."
  type = map(list(object({
    service_account_id = string # Must match a key in var.service_accounts
    role_id            = string # Must match a key in var.custom_roles
  })))
  default = {
    # This structure is different from your custom_role_bindings;
    # it's simpler for 1-to-1 SA-to-Role binding for an example.
    # A more general-purpose structure is provided in the resource block.
  }
}


# -----------------------------------------------------------------------------
# REQUIRED VARIABLES
# -----------------------------------------------------------------------------

variable "project_id" {
  description = "The ID of the project where the custom roles will be created."
  type        = string
}

variable "custom_roles" {
  description = "A map where keys are custom role IDs and values are a list of predefined roles to inherit permissions from."
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

# variable "custom_role_bindings" {
#   description = "A map where the key is the custom role_id and the value is a list of members (users/groups) to be bound to that role."
#   type        = map(list(string))
# }