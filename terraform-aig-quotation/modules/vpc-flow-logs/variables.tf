variable "organization_id" {
  description = "The ID of your Google Cloud Organization"
  type        = string
}

variable "flow_logs_location" {
  description = "The location for the VpcFlowLogsConfig resource. This must be 'global'."
  type        = string
  default     = "global"
}

variable "vpc_flow_logs_config_id" {
  description = "The unique ID for the VpcFlowLogsConfig resource. This ID forms the final segment of the resource name (e.g., 'my-flow-log-config'). Must be 1-63 characters, and match the regex [a-z]([-a-z0-9]*[a-z0-9])?."
  type        = string
}

variable "description" {
  description = "An optional description of the VPC flow logs configuration."
  type        = string
  default     = "Organization VPC Flow Log Configuration"
}

variable "state" {
  description = "The desired state of the VPC Flow Logs configuration. Must be one of 'ACTIVE' or 'INACTIVE'."
  type        = string
  default     = "ENABLED"
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

variable "metadata" {
  description = "Whether to include or exclude metadata fields. Must be 'INCLUDE_ALL_METADATA' or 'EXCLUDE_ALL_METADATA'."
  type        = string
  default     = "INCLUDE_ALL_METADATA"
}

variable "metadata_fields" {
  description = "List of metadata fields to include or exclude. Only used if 'metadata' is 'EXCLUDE_ALL_METADATA'. If used, must be a list of valid metadata field names."
  type        = list(string)
  default     = []
}

variable "filter_expr" {
  description = "A filter expression for VPC flow logs. Traffic that matches this expression is logged."
  type        = string
  default     = ""
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