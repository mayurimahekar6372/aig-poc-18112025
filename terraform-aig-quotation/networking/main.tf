module "non_prod_vpc_host" {
  source          = "../modules/net-vpc"
  project_id      = data.terraform_remote_state.projects.outputs.non_prod_host_project_id
  name            = "non-prod-host-vpc"
  subnets         = var.non_prod_vpc_subnets
  shared_vpc_host = true
  shared_vpc_service_projects = [
    data.terraform_remote_state.projects.outputs.non_prod_service_project_id,
    data.terraform_remote_state.projects.outputs.gi_japan_sonpo_non_prod_project_id,
    data.terraform_remote_state.projects.outputs.gi_japan_ah_non_prod_project_id
  ]
  subnets_proxy_only = var.subnets_proxy_only
  subnets_psc        = var.subnets_psc
}

module "vpc-hub-network" {
  source     = "../modules/net-vpc"
  project_id = data.terraform_remote_state.projects.outputs.hub_network_project_id
  name       = "hub-vpc-network"
  subnets    = var.hub_vpc_subnets
  peering_config = {
    peer_vpc_self_link = module.non_prod_vpc_host.self_link
    import_routes      = true
    export_routes      = true
  }
  # dns_policy = {
  #   logging = true
  # }
  depends_on = [
    module.non_prod_vpc_host
  ]
}