variable "project_id" {
  description = "The ID of the google cloud project."
  type        = string
}

variable "region" {
  description = "The region to deploy the firestore service."
  type        = string
}

variable "database_name" {
  description = "The name for the firestore database."
  type        = string
}
