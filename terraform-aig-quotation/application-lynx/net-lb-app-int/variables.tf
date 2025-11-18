variable "project_id" {
  description = "The ID of the google cloud project."
  type        = string
}

variable "infra_project_id" {
  description = "The ID of the infrastructure google cloud project."
  type        = string
}

variable "region" {
  description = "The region to deploy the internal load balancer service."
  type        = string
}

variable "vpc_network_name" {
  description = "The name of the vpc network to reference in the infra project."
  type        = string
}

variable "app_subnet_name" {
  description = "The name of the subnet where applications will reside."
  type        = string
}

variable "psc_subnet_name" {
  description = "The name of the subnet dedicated for Private Service Connect (PSC) endpoints."
  type        = string
}

variable "ilb_quotation_name" {
  description = "The name for the quotation internal load balancer."
  type        = string
}

variable "cert_name" {
  description = "The name of the certificate"
  type        = string
}

variable "lynx_ip_address" {
  description = "IP Address for Lynx ILB"
  type        = string
}

variable "labels" {
  description = "List of labels"
  type        = map(string)
}