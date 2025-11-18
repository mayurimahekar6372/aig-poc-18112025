#output "created_rule_names" {
#  description = "A list of the names of the ingress firewall rules that were created."
#  # This collects the 'name' attribute from every firewall rule created by the resource block.
#  value       = values(google_compute_firewall.ingress)[*].name
#}