locals {
  # 1. Define the networks we can deploy rules to, getting their details from remote state.
  target_networks = {
    "non-prod-host" = {
      project_id = data.terraform_remote_state.projects.outputs.non_prod_host_project_id
      name       = data.terraform_remote_state.networking.outputs.non_prod_vpc_name
    },
    "hub-network" = {
      project_id = data.terraform_remote_state.projects.outputs.hub_network_project_id
      name       = data.terraform_remote_state.networking.outputs.hub_vpc_name
    }
  }

  # 2. Group the firewall rules from the .tfvars file by their target network.
  rules_by_network = {
    for network_key, network_config in local.target_networks : network_key => {
      for rule_key, rule_config in var.ingress_rules : rule_key => rule_config
      if rule_config.target_network == network_key
    }
  }
}

# 3. For each network that has rules defined, call the firewall module to create them.
module "firewall_rules" {
  for_each = local.rules_by_network

  source = "../modules/net-vpc-firewall"

  project_id    = local.target_networks[each.key].project_id
  network       = local.target_networks[each.key].name
  ingress_rules = each.value # Pass the filtered map of rules for this specific network
}