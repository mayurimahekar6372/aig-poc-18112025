locals {
  projects_list = [
    data.terraform_remote_state.projects.outputs.hub_network_project_id,
    data.terraform_remote_state.projects.outputs.non_prod_host_project_id,
    data.terraform_remote_state.projects.outputs.non_prod_service_project_id
  ]
  vpc_list = [
    data.terraform_remote_state.networking.outputs.hub_vpc_self_link,
    data.terraform_remote_state.networking.outputs.non_prod_vpc_self_link
  ]

  dynamic_perimeter_resources = concat(
    [for project_id in local.projects_list : "projects/${data.google_project.remote_state_projects[project_id].number}"],

    [for project_id in var.additional_projects : "projects/${data.google_project.additional_projects[project_id].number}"],

    [
      for vpc_link in local.vpc_list : replace(vpc_link,
        "https://www.googleapis.com/compute/v1",
        "//compute.googleapis.com"
      )
    ],

    # [
    #   for vpc_link in data.google_compute_network.self_link : replace(vpc_link,
    #     "https://www.googleapis.com/compute/v1",
    #     "//compute.googleapis.com"
    #   )
    # ]
  )

  perimeters_map = {
    for name, config in var.perimeter_config : name => {
      title                     = config.title
      use_explicit_dry_run_spec = config.use_explicit_dry_run_spec

      spec = merge(config.spec, {
        resources = local.dynamic_perimeter_resources
        access_levels = [
          #   for key in config.access_level_keys : local.access_level_id_map[key]
          for key in config.access_level_keys : module.vpc_access_levels.access_level_names[key]
        ]
        # ingress_policies = [
        #   for polciy in config.ingress_policies : module.vpc_ingress_egress_policies.ingress_polcies[key]
        # ]
      })

      status = merge(config.status, {
        resources = local.dynamic_perimeter_resources
        access_levels = [
          #   for key in config.access_level_keys : local.access_level_id_map[key]
          for key in config.access_level_keys : module.vpc_access_levels.access_level_names[key]
        ]
      })
    }
  }
}

data "google_access_context_manager_access_policy" "policy-org" {
  parent = var.organization_id
}

data "google_project" "remote_state_projects" {
  for_each   = toset(local.projects_list)
  project_id = each.key
}

# New data block to fetch project numbers for manually created projects
data "google_project" "additional_projects" {
  for_each   = toset(var.additional_projects)
  project_id = each.key
}

# data "google_compute_network" "additional_vpcs" {
#   for_each = toset(var.additional_vpcs)
#   name     = each.key
# }

module "vpc_access_levels" {
  source        = "../modules/vpc-sc"
  access_policy = data.google_access_context_manager_access_policy.policy-org.id
  access_levels = var.access_levels
}

module "vpc_ingress_egress_policies" {
  source           = "../modules/vpc-sc"
  # access_policy    = data.google_access_context_manager_access_policy.policy-org.
  access_polic
  
  ingress_policies = var.ingress_policies
  egress_policies  = var.egress_policies
}

module "vpc_sc" {
  source        = "../modules/vpc-sc"
  access_policy = data.google_access_context_manager_access_policy.policy-org.id
  perimeters    = local.perimeters_map
}

