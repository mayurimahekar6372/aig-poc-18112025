variable "non_prod_vpc_subnets" {
  type = list(object({
    ip_cidr_range = string
    name          = string
    region        = string
    secondary_ip_ranges = map(object({
      ip_cidr_range = string
    }))
  }))
  description = "A list of subnets for the non-prod host VPC."
}

variable "hub_vpc_subnets" {
  type = list(object({
    ip_cidr_range = string
    name          = string
    region        = string
  }))
  description = "A list of subnets for the hub network VPC."
}

variable "subnets_proxy_only" {
  description = "List of proxy-only subnets for Regional HTTPS or Internal HTTPS load balancers. Note: Only one proxy-only subnet for each VPC network in each region can be active."
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
    description   = optional(string)
    active        = optional(bool, true)
    global        = optional(bool, false)
  }))
  default = []
}

variable "subnets_psc" {
  description = "List of subnets for Private Service Connect service producers."
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
    description   = optional(string)
  }))
  default = []
}
