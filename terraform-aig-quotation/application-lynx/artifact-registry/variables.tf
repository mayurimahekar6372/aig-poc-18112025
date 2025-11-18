variable "project_id" {
  description = "The ID of the google cloud project."
  type        = string
}

variable "region" {
  description = "The region to deploy the artifact registry service."
  type        = string
}

variable "repository_name" {
  description = "The unique name/ID for the artifact registry repository."
  type        = string
}
