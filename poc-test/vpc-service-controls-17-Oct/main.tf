module "prod_vpc_sc" {
  source           = "../modules/vpc-sc"
  access_policy    = data.google_access_context_manager_access_policy.policy-org.id
  access_levels    = var.vpc_sc_configs["prod_config"].access_levels
  egress_policies  = var.vpc_sc_configs["prod_config"].egress_policies
  ingress_policies = var.vpc_sc_configs["prod_config"].ingress_policies
  perimeters       = local.prod_perimeters_map
}

# module "non_prod_vpc_sc" {
#   source           = "../modules/vpc-sc"
#   access_policy    = data.google_access_context_manager_access_policy.policy-org.id
#   access_levels    = var.vpc_sc_configs["dev_config"].access_levels
#   egress_policies  = var.vpc_sc_configs["dev_config"].egress_policies
#   ingress_policies = var.vpc_sc_configs["dev_config"].ingress_policies
#   perimeters       = local.non_prod_perimeters_map
# }