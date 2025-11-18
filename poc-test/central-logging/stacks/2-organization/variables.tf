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