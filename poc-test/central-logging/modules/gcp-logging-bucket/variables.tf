variable "project_id" {
  description = "The project ID to create the log bucket in."
  type        = string
}

variable "bucket_name" {
  description = "The name for the new log bucket (e.g., 'vpc-flow-logs-bucket')."
  type        = string
}

variable "location" {
  description = "The location for the log bucket."
  type        = string
  default     = "global"
}

variable "retention_days" {
  description = "The number of days to retain logs in this bucket."
  type        = number
  default     = 30
}