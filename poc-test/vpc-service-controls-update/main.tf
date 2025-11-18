module "prod_vpc_sc" {
  source        = "../modules/vpc-sc"
  access_policy = null
  access_policy_create = {
    parent = var.organization_id
    title  = var.access_policy_title
  }
  access_levels    = var.vpc_sc_configs["prod_config"].access_levels
  egress_policies  = var.vpc_sc_configs["prod_config"].egress_policies
  ingress_policies = var.vpc_sc_configs["prod_config"].ingress_policies
  perimeters       = local.perimeters_map
}

# module "non_prod_vpc_sc" {
#   source           = "../modules/vpc-sc"
#   access_policy    = null
#   access_policy_create = {
#     parent = var.organization_id
#     title = ""
#   }
#   access_levels    = var.vpc_sc_configs["dev_config"].access_levels
#   egress_policies  = var.vpc_sc_configs["dev_config"].egress_policies
#   ingress_policies = var.vpc_sc_configs["dev_config"].ingress_policies
#   perimeters       = local.non_prod_perimeters_map
# }