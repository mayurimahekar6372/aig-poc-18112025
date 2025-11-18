variable "projects_config" {
  description = "A map where keys are project identifiers and values are lists of services to enable."
  type        = map(list(string))
  default     = {}
}