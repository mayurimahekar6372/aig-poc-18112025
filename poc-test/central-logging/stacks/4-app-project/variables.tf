# This is the fix for your error.
# The variable *definition* belongs in a .tf file.
variable "project_id" {
  description = "The project ID for this application."
  type        = string
}

variable "enable_flow_logs" {
  description = "Toggle for enabling VPC flow logs on the subnets."
  type        = bool
  default     = true
}