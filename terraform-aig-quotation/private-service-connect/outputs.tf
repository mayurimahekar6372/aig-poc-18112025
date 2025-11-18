output "hub_psc_selflink" {
  description = "The selflink of the private service connect."
  value       = module.hub_psc.psc_addresses.hubpsc.self_link
}

output "non_prod_host_psc_selflink" {
  description = "The selflink of the private service connect."
  value       = module.non_prod_host_psc.psc_addresses.hostpsc.self_link
}

output "hub_psc_ip" {
  description = "The ip address of the hub private service connect"
  value       = module.hub_psc.psc.googleapis.address.address
}

output "non_prod_host_psc_ip" {
  description = "The ip address of the host private service connect"
  value       = module.non_prod_host_psc.psc.googleapis.address.address
}