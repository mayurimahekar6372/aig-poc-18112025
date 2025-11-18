module "vpc_access_policy" {
  source        = "../modules/vpc-sc"
  access_policy = null
  access_policy_create = {
    parent = var.organization_id
    title  = var.access_policy_title
  }
}

module "prod_vpc_sc" {
  source           = "../modules/vpc-sc"
  access_policy    = module.vpc_access_policy.id
  access_levels    = var.vpc_sc_configs["sc_config"].access_levels
  egress_policies  = var.vpc_sc_configs["sc_config"].egress_policies
  ingress_policies = var.vpc_sc_configs["sc_config"].ingress_policies
  perimeters       = local.perimeters_map
}