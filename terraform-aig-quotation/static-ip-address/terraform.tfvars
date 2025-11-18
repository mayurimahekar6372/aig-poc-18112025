static_addresses_config = {
  "ip-address1" = {
    project_id_key = "non_prod_host_project_id" // Projects Output Id used in projects -> outputs.tf
    internal_addresses = {
      nprod-ilb-ip = { // Static IP Address Name
        address = "10.0.0.100"
        labels = {
          bu-environment-type = "non-prod"
          bu-application-name = "google-cloud-platform"
        }
        region         = "us-central1"
        subnetwork_key = "non_prod_subnet_self_link" // Subnet Selflink Output Id used in networking -> outputs.tf
      }
    }
  }
  # "ip-address2" = {
  #   project_id_key = "hub_network_project_id"
  #   internal_addresses = {
  #     hub-ilb-ip = {
  #       address = "10.10.0.100"
  #       labels = {
  #         bu-environment-type = "non-prod"
  #         bu-application-name = "google-cloud-platform"
  #       }
  #       description    = ""
  #       name           = ""
  #       purpose        = ""
  #       region         = "us-central1"
  #       subnetwork_key = "hub_subnet_self_link"
  #     }
  #   }
  # }
}