variable "project_id" {
  description = "The ID of the google cloud project."
  type        = string
}

variable "region" {
  description = "The region to deploy the cloud storage service."
  type        = string
}

variable "bucket_name_prefix" {
  description = "The prefix used for the cloud stoarge bucket name."
  type        = string
}

variable "bucket_quotation_name" {
  description = "The name for the cloud storage quotation bucket."
  type        = string
}

variable "bucket_transcription_name" {
  description = "The name for the cloud storage transcription bucket."
  type        = string
}

variable "cors_quotation" {
  description = "CORS configuration for the quotation bucket. Defaults to null."
  type = object({
    origin          = optional(list(string))
    method          = optional(list(string))
    response_header = optional(list(string))
    max_age_seconds = optional(number)
  })
  default = null
}

variable "cors_transcription" {
  description = "CORS configuration for the transcription bucket. Defaults to null."
  type = object({
    origin          = optional(list(string))
    method          = optional(list(string))
    response_header = optional(list(string))
    max_age_seconds = optional(number)
  })
  default = null
}