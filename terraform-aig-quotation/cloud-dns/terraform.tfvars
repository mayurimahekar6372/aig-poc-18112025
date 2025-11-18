hub_domain    = "aigpoc.com."
hub_zone_name = "hub-poc-forwarding"
hub_forwarders = {
  "167.230.93.3" = "private",
  "167.230.93.5" = "private"
}

non_prod_domain    = "aigpoc.com."
non_prod_zone_name = "non-prod-poc-peering"
# non_prod_forwarders = {
#   "167.230.93.3" = null,
#   "167.230.93.5" = null
# }

hub_googleapis_dns_zone   = "googleapis-zone"
hub_googleapis_dns_domain = "pgoogleapis.com."

hub_gpc_cloud_aig_net_dns_zone   = "gcp-cloud-aig-net-zone"
hub_gpc_cloud_aig_net_dns_domain = "gcp.cloud.aig.net."
labels = {
  bu-environment-type = "non-prod"
  bu-application-name = "google-cloud-platform"
}