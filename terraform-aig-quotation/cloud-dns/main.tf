module "hub-private-dns" {
  source     = "../modules/dns"
  project_id = data.terraform_remote_state.projects.outputs.hub_network_project_id
  name       = var.hub_zone_name
  zone_config = {
    domain = var.hub_domain
    forwarding = {
      client_networks = [data.terraform_remote_state.networking.outputs.hub_vpc_self_link]
      forwarders      = var.hub_forwarders
    }
  }
  labels = var.labels
}

# module "nprod-host-private-dns" {
#   source     = "../modules/dns"
#   project_id = data.terraform_remote_state.projects.outputs.non_prod_host_project_id
#   name       = var.non_prod_zone_name
#   zone_config = {
#     domain = var.non_prod_domain
#     forwarding = {
#       client_networks = [data.terraform_remote_state.networking.outputs.non_prod_vpc_self_link]
#       forwarders      = var.non_prod_forwarders
#     }
#   }
# }

module "nprod-host-peering-dns" {
  source     = "../modules/dns"
  project_id = data.terraform_remote_state.projects.outputs.non_prod_host_project_id
  name       = var.non_prod_zone_name
  zone_config = {
    domain = var.non_prod_domain
    peering = {
      client_networks = [data.terraform_remote_state.networking.outputs.non_prod_vpc_self_link]
      peer_network    = data.terraform_remote_state.networking.outputs.hub_vpc_self_link
    }
  }
  labels = var.labels
}

module "hub-googleapis-dns" {
  source     = "../modules/dns"
  project_id = data.terraform_remote_state.projects.outputs.hub_network_project_id
  name       = var.hub_googleapis_dns_zone
  zone_config = {
    domain = var.hub_googleapis_dns_domain
    private = {
      client_networks = [
        data.terraform_remote_state.networking.outputs.hub_vpc_self_link,
        data.terraform_remote_state.networking.outputs.non_prod_vpc_self_link
      ]
    }
  }
  recordsets = {
    "A "      = { ttl = 300, records = [data.terraform_remote_state.private-service-connect.outputs.hub_psc_ip] }
    "CNAME *" = { ttl = 300, records = [var.hub_googleapis_dns_domain] }
  }
  labels = var.labels
}


module "hub-gcp-cloud-aig-net-dns" {
  source     = "../modules/dns"
  project_id = data.terraform_remote_state.projects.outputs.hub_network_project_id
  name       = var.hub_gpc_cloud_aig_net_dns_zone
  zone_config = {
    domain = var.hub_gpc_cloud_aig_net_dns_domain
    private = {
      client_networks = [
        data.terraform_remote_state.networking.outputs.hub_vpc_self_link,
        data.terraform_remote_state.networking.outputs.non_prod_vpc_self_link
      ]
    }
  }
  recordsets = {
    "A "        = { ttl = 300, records = [data.terraform_remote_state.private-service-connect.outputs.hub_psc_ip] }
    "A ilb.poc" = { ttl = 300, records = [data.terraform_remote_state.static-ip-address.outputs.static_ip_addresses["nprod-ilb-ip"]] }
    "A poc" = { ttl = 60, records = [data.terraform_remote_state.application-lynx.outputs.ip_address] }

  }
  labels = var.labels
}