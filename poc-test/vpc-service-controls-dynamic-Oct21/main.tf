module "vpc_access_policy" {
  source        = "../modules/vpc-sc"
  access_policy = null
  access_policy_create = {
    parent = var.organization_id
    title  = var.access_policy_title
  }
}

module "vpc_sc" {
  for_each = var.vpc_sc_configs

  source        = "../modules/vpc-sc"

  access_policy = module.vpc_access_policy.id
  access_levels    = each.value.access_levels
  egress_policies  = each.value.egress_policies
  ingress_policies = each.value.ingress_policies
  perimeters = {
    for key, p_config in local.perimeters_map :
    key => p_config
    if startswith(key, "${each.key}_")
  }
}