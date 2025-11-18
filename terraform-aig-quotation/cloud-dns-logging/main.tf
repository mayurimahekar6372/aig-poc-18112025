resource "google_dns_policy" "example-policy" {
  name                      = "dns-policy"
    project = data.terraform_remote_state.projects.outputs.non_prod_host_project_id
  enable_logging = true

  networks {
    network_url = data.terraform_remote_state.networking.outputs.non_prod_vpc_self_link
  }

}
