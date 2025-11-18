# These are the *definitions* of variables this stack needs
variable "project_id" {
  description = "The project ID for the central logging project."
  type        = string
}

variable "bucket_name" {
  description = "The name of the log bucket to create."
  type        = string
}

variable "retention_days" {
  description = "Retention period for the log bucket."
  type        = number
}