variable "project_id" {
  description = "The ID of the Google Cloud project where services will be enabled."
  type        = string
}

variable "services" {
  description = "A list of service API names (e.g., 'compute.googleapis.com') to enable."
  type        = list(string)
}

variable "disable_on_destroy" {
  description = "Whether the service should be disabled when the resource is destroyed."
  type        = bool
  default     = false
}

variable "disable_dependent_services" {
  description = "Whether to disable dependent services when disabling a service."
  type        = bool
  default     = false
}