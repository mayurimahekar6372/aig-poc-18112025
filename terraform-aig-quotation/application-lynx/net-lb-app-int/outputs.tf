# output "ilb_quotation_name" {
#   description = "Internal Load Balancer Quotation Name."
#   value       = module.ilb_quotation.forwarding_rule.name
# }

# output "certificate" {
#   value = data.google_certificate_manager_certificates.certificate.id
# }

output "certificates_names" {
  value = [for cert in data.google_certificate_manager_certificates.default.certificates : cert.name]
}

output "ip_address" {
  value = module.ip_address.internal_addresses.lynx-ip.address
}

# output "domain_name" {
# value = data.terraform_remote_state.cloud-dns.outputs.gcp-cloud-aig-net-name
# }