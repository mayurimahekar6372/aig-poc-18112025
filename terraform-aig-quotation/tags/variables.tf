variable "organization_id" {
  description = "Organization id in organizations/nnnnnn format."
  type        = string
  validation {
    condition     = can(regex("^organizations/[0-9]+", var.organization_id))
    error_message = "The organization_id must in the form organizations/nnn."
  }
}

variable "tag_definitions" {
  description = "A map defining the Tag Keys and their associated Tag Values to be created."
  type = map(object({
    description = optional(string)
    values = map(object({
      description = optional(string)
    }))
  }))
  default = {}
}