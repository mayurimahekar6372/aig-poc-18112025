variable "organization_id" {
  description = "Organization id in organizations/nnnnnn format."
  type        = string
  validation {
    condition     = can(regex("^organizations/[0-9]+", var.organization_id))
    error_message = "The organization_id must in the form organizations/nnn."
  }
}

variable "access_levels" {
  description = "Access level definitions."
  type = map(object({
    combining_function = optional(string)
    conditions = optional(list(object({
      ip_subnetworks = optional(list(string), [])
      members        = optional(list(string), [])
      regions        = optional(list(string), [])
    })), [])
  }))
  default = {}
}

variable "perimeter_config" {
  description = "Configuration for VPC Service Control perimeters."
  type = map(object({
    title                     = string
    use_explicit_dry_run_spec = optional(bool, true)
    access_level_keys         = optional(list(string), [])
    spec = object({
      restricted_services = optional(list(string), [])
      ingress_policies    = optional(list(any), [])
      egress_policies     = optional(list(any), [])
      vpc_accessible_services = object({
        allowed_services   = list(string)
        enable_restriction = optional(bool, true)
      })
    }, [])
    status = object({
      restricted_services = optional(list(string), [])
      ingress_policies    = optional(list(any), [])
      egress_policies     = optional(list(any), [])
      vpc_accessible_services = object({
        allowed_services   = list(string)
        enable_restriction = optional(bool, true)
      })
    })
  }))
}

variable "additional_projects" {
  description = "List of project IDs that are manually created or managed outside of this Terraform state, but need to be included in the VPC SC perimeter resources."
  type        = list(string)
  default     = []
}

variable "additional_vpcs" {
  description = "List of VPC network"
  type        = list(string)
  default     = []
}

variable "ingress_policies" {
  description = "Ingress policy definitions that can be referenced in perimeters."
  type = map(object({
    title = optional(string)
    from = object({
      access_levels = optional(list(string), [])
      identity_type = optional(string)
      identities    = optional(list(string))
      resources     = optional(list(string), [])
    })
    to = object({
      operations = optional(list(object({
        method_selectors     = optional(list(string))
        permission_selectors = optional(list(string))
        service_name         = string
      })), [])
      resources = optional(list(string))
      roles     = optional(list(string))
    })
  }))
  default  = {}
}

variable "egress_policies" {
  description = "Egress policy definitions that can be referenced in perimeters."
  type = map(object({
    title = optional(string)
    from = object({
      access_levels = optional(list(string), [])
      identity_type = optional(string)
      identities    = optional(list(string))
      resources     = optional(list(string), [])
    })
    to = object({
      external_resources = optional(list(string))
      operations = optional(list(object({
        method_selectors     = optional(list(string))
        permission_selectors = optional(list(string))
        service_name         = string
      })), [])
      resources = optional(list(string))
      roles     = optional(list(string))
    })
  }))
  default  = {}
}