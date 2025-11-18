variable "ingress_rules" {
  description = "A map of ingress firewall rules, where each rule specifies its target network."
  type = map(object({
    description    = optional(string)
    source_ranges  = list(string)
    target_tags    = optional(list(string))
    rules          = list(object({
      protocol = string
      ports    = optional(list(string))
    }))
    # This new attribute tells Terraform which network to target
    target_network = string
  }))
  default = {}
}