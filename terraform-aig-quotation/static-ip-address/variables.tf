variable "static_addresses_config" {
  description = "A map containing configurations for addresses across different projects and networks."
  type = map(object({
    project_id_key = string
    internal_addresses = map(object({
      address        = optional(string)
      description    = optional(string)
      ipv6           = optional(map(string))
      labels         = optional(map(string))
      purpose        = optional(string)
      region         = string
      subnetwork_key = string
    }))
  }))
}