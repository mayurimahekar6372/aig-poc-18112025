variable "billing_account" {
  type        = string
  description = "The billing account ID to associate with projects."
}

# variable "project_details" {
#   type        = map(object({ name = string, prefix = string, labels = map(string), services = optional(list(string)) }))
#   description = "A map of project configurations."
# }

#Enhancement
variable "project_details" {
  type = map(object({
    name = string,
    prefix = string,
    labels = map(string),
    parent_output_key = string # A key to reference the correct folder ID from remote state
    services = optional(list(string)),
  }))
}