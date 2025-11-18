variable "vm_instances" {
  description = "A map of Compute Engine VM instances to create."
  type = map(object({
    name           = string
    region         = string
    machine_type   = optional(string, "e2-medium") # Default to e2-medium
    target_network = string                        # "shared-service" or "hub-network"
    labels         = map(string)
  }))
  default = {}
}

# variable "labels" {
#   description = "Instance labels."
#   type        = map(string)
#   default     = {}
# }