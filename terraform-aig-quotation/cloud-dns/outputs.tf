output "hub-dns-name" {
  value = module.hub-private-dns.domain
}

output "hub-dns-zone" {
  value = module.hub-private-dns.name
}

output "non-prod-dns-name" {
  value = module.nprod-host-peering-dns.domain
}

output "non-prod-dns-zone" {
  value = module.nprod-host-peering-dns.name
}

output "googleapis-name" {
  value = module.hub-googleapis-dns.domain
}

output "googleapis-zone" {
  value = module.hub-googleapis-dns.name
}

output "gcp-cloud-aig-net-name" {
  value = module.hub-gcp-cloud-aig-net-dns.domain
}

output "gcp-cloud-aig-net-zone" {
  value = module.hub-gcp-cloud-aig-net-dns.name
}