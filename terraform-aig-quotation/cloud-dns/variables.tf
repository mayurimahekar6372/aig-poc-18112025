variable "hub_domain" {
  description = "Domain name used for the DNS zone"
  type        = string
}

variable "hub_zone_name" {
  description = "Zone name, must be unique within the project."
  type        = string
}

variable "non_prod_domain" {
  description = "Domain name used for the DNS zone"
  type        = string
}

variable "non_prod_zone_name" {
  description = "Zone name, must be unique within the project."
  type        = string
}

variable "hub_forwarders" {
  description = "Zone forwarding target ips"
  type        = map(string)
}

variable "hub_googleapis_dns_domain" {
  description = "Domain name used for the DNS zone"
  type        = string
}

variable "hub_googleapis_dns_zone" {
  description = "Zone name, must be unique within the project."
  type        = string
}

variable "hub_gpc_cloud_aig_net_dns_domain" {
  description = "Domain name used for the DNS zone"
  type        = string
}

variable "hub_gpc_cloud_aig_net_dns_zone" {
  description = "Zone name, must be unique within the project."
  type        = string
}

variable "labels" {
  description = "Labels for Cloud DNS"
  type        = map(string)
}