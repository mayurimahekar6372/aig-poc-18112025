# variable "retention_days" {
#   description = "The new number of days to retain logs in the _Default bucket."
#   type        = number
#   default     = 30
# }

# variable "log_bucket_name" {
#   description = "The ID of the default logging bucket in a project, folder, or organization. This is typically '_Default'."
#   type        = string
#   default     = "_Default"
# }

# variable "log_prj_bucket_name" {
#   description = "The ID of the default logging bucket in a project, folder, or organization. This is typically '_Default'."
#   type        = string
#   default     = "_Default"
# }

variable "logging_buckets" {
  description = "A map of logging bucket configurations"
  type = map(object({
    parent_type    = string
    project_id_key = string # Key to look up the project ID from remote state
    name           = string
    retention      = number
  }))
}

# Variable *definitions*
variable "sink_name" {
  description = "Name of the organization sink."
  type        = string
}

variable "org_id" {
  description = "Your GCP Organization ID."
  type        = string
}

variable "vpc_log_filter" {
  description = "The filter to select only VPC Flow Logs."
  type        = string
  default     = "log_name:\"logs/compute.googleapis.com%2Fvpc_flows\""
}