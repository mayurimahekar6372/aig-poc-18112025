variable "organization_id" {
  type        = string
  description = "The ID of the Google Cloud organization (e.g., '123456789012')."
}

variable "billing_project" {
  type        = string
  description = "A project ID to use for billing provider operations."
}

variable "org_custom_roles" {
  description = "A map where keys are custom role IDs and values are lists of IAM permissions for organization."
  type        = map(list(string))
  default     = {}
}

variable "org_role_bindings" {
  description = "A map where the key is the custom role_id and the value is a list of members (users/groups) to be bound to that role."
  type        = map(list(string))
}

variable "hub_project_custom_roles" {
  description = "A map where keys are custom role IDs and values are lists of IAM permissions for organization."
  type        = map(list(string))
  default     = {}
}

variable "hub_project_excluded_permissions" {
  description = "List of permissions to exclude from the final custom role, overriding the default exclusions."
  type        = list(string)
  default     = []
}

variable "hub_project_role_bindings" {
  description = "A map where the key is the custom role_id and the value is a list of members (users/groups) to be bound to that role."
  type        = map(list(string))
  default     = {}
}

variable "non_prod_host_project_custom_roles" {
  description = "A map where keys are custom role IDs and values are lists of IAM permissions for organization."
  type        = map(list(string))
  default     = {}
}

variable "non_prod_host_project_excluded_permissions" {
  description = "List of permissions to exclude from the final custom role, overriding the default exclusions."
  type        = list(string)
  default     = []
}

variable "non_prod_host_project_role_bindings" {
  description = "A map where the key is the custom role_id and the value is a list of members (users/groups) to be bound to that role."
  type        = map(list(string))
  default     = {}
}

variable "organization_excluded_permissions" {
  description = "List of permissions to exclude from the final custom role, overriding the default exclusions."
  type        = list(string)
  default     = []
}