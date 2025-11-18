module "static_addresses" {
  for_each = var.static_addresses_config
  source   = "../modules/net-address"

  project_id = data.terraform_remote_state.projects.outputs[each.value.project_id_key]
  internal_addresses = {
    for name, config in each.value.internal_addresses : name => {
      address     = lookup(config, "address", null)
      description = lookup(config, "description", null)
      ipv6        = lookup(config, "ipv6", null)
      labels      = lookup(config, "labels", null)
      name        = lookup(config, "name", null)
      purpose     = lookup(config, "purpose", null)
      region      = config.region
      subnetwork  = data.terraform_remote_state.networking.outputs[config.subnetwork_key]
    }
  }
}