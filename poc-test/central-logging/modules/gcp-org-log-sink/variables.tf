variable "sink_name" {
  description = "The name for the new organization sink."
  type        = string
}

variable "org_id" {
  description = "The Google Cloud Organization ID."
  type        = string
}

variable "destination_bucket_id" {
  description = "The full ID of the destination bucket (from the logging bucket's output)."
  type        = string
}

variable "filter" {
  description = "The logging filter to apply for this sink."
  type        = string
}