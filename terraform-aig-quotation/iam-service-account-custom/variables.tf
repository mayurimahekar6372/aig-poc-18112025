variable "service_account_name" {
  description = "Name of the service account to create."
  type        = map(string)
}

variable "service_account_custom_roles" {
  description = "A map where keys are custom role IDs and values are lists of IAM permissions for organization."
  type        = map(list(string))
  default     = {}
}

variable "service_account_role_bindings" {
  description = "Map of custom role IDs to a list of service account IDs that should receive that role."
  type        = map(list(string))
  default     = {}
}