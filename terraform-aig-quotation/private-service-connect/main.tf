module "hub_psc" {
  source     = "../modules/net-address"
  project_id = data.terraform_remote_state.projects.outputs.hub_network_project_id
  psc_addresses = {
    googleapis = {
      name    = var.hub_psc_name
      address = var.hub_psc_address
      network = data.terraform_remote_state.networking.outputs.hub_vpc_self_link
      service_attachment = {
        psc_service_attachment_link = "all-apis"
      }
    }
  }
}


module "non_prod_host_psc" {
  source     = "../modules/net-address"
  project_id = data.terraform_remote_state.projects.outputs.non_prod_host_project_id
  psc_addresses = {
    googleapis = {
      name    = var.non_prod_host_psc_name
      address = var.non_prod_host_psc_address
      network = data.terraform_remote_state.networking.outputs.non_prod_vpc_self_link
      service_attachment = {
        psc_service_attachment_link = "all-apis"
      }
    }
  }
}
