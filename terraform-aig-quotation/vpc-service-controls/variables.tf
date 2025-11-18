variable "organization_id" {
  description = "Organization id in organizations/nnnnnn format."
  type        = string
  validation {
    condition     = can(regex("^organizations/[0-9]+", var.organization_id))
    error_message = "The organization_id must in the form organizations/nnn."
  }
}

variable "access_policy_title" {
  description = "The title for the Access Context Manager Access Policy."
  type        = string
}

variable "excluded_projects" {
  type = list(string)
}

variable "excluded_vpcs" {
  type = list(string)
}

variable "vpc_sc_configs" {
  description = "A map of independent VPC Service Controls configuration sets, keyed by environment/purpose."
  type = map(object({

    access_levels = map(object({
      combining_function = string
      conditions = list(object({
        ip_subnetworks = optional(list(string))
        members        = optional(list(string))
      }))
    }))

    egress_policies = map(object({
      from = optional(object({
        access_levels = optional(list(string), [])
        identity_type = optional(string)
        identities    = optional(list(string))
        resources     = optional(list(string), [])
      }))
      to = object({
        operations = list(object({
          method_selectors = list(string)
          service_name     = string
        }))
        resources = list(string)
      })
    }))

    ingress_policies = map(object({
      title = string
      from = object({
        access_levels = optional(list(string), [])
        identity_type = optional(string)
        identities    = optional(list(string))
        resources     = optional(list(string), [])
      })
      to = object({
        resources = list(string)
        operations = list(object({
          service_name     = string
          method_selectors = list(string)
        }))
      })
    }))

    perimeters = map(object({
      title                     = optional(string)
      use_explicit_dry_run_spec = optional(bool)
      spec = optional(object({
        access_levels    = optional(list(string))
        ingress_policies = optional(list(string))
        egress_policies  = optional(list(string))
      }))
      status = optional(object({
        access_levels    = optional(list(string))
        ingress_policies = optional(list(string))
        egress_policies  = optional(list(string))
      }))
    }))
  }))
}
