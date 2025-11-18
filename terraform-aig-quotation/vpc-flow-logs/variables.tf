variable "organization_id" {
  description = "The ID of your Google Cloud Organization"
  type        = string
}

variable "vpc_flow_logs_config_id" {
  description = "The unique ID for the VpcFlowLogsConfig resource. This ID forms the final segment of the resource name (e.g., 'my-flow-log-config'). Must be 1-63 characters, and match the regex [a-z]([-a-z0-9]*[a-z0-9])?."
  type        = string
}

variable "aggregation_interval" {
  description = "The aggregation interval for VPC flow logs. Valid values are 'INTERVAL_5_SEC', 'INTERVAL_30_SEC', 'INTERVAL_1_MIN', 'INTERVAL_5_MIN', 'INTERVAL_10_MIN' or 'INTERVAL_15_MIN'."
  type        = string
  default     = "INTERVAL_5_SEC"
}

variable "flow_sampling" {
  description = "The sampling rate of VPC flow logs. Values can range from 0.0 to 1.0. A value of 0.5 means 50% of the traffic is logged."
  type        = number
  default     = 1.0
}

variable "cross_project_metadata" {
  description = "Whether to enable logging for inter-VPC flows (cross-project traffic). Must be 'CROSS_PROJECT_METADATA_DISABLED' or 'CROSS_PROJECT_METADATA_ENABLED'."
  type        = string
  default     = "CROSS_PROJECT_METADATA_ENABLED"
}

variable "labels" {
  description = "Labels to apply to the resource, in the format map(string). Used for organizational purposes."
  type        = map(string)
  default     = {}
}