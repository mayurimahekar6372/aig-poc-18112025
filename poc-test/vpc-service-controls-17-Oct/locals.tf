locals {
  project_vpc_list = flatten([
    for project_id, vpc_names in var.additional_projects_vpcs : [
      for vpc_name in vpc_names : {
        project = project_id
        name    = vpc_name
        key     = "${project_id}:${vpc_name}"
      }
    ]
  ])

  project_vpc_map = {
    for vpc in local.project_vpc_list : vpc.key => vpc
  }

  prod_projects_list = [
    data.terraform_remote_state.projects.outputs.hub_network_project_id
  ]

  prod_vpc_list = [
    data.terraform_remote_state.networking.outputs.hub_vpc_self_link
  ]

  non_prod_projects_list = [
    data.terraform_remote_state.projects.outputs.non_prod_host_project_id,
    data.terraform_remote_state.projects.outputs.non_prod_service_project_id
  ]

  non_prod_vpc_list = [
    data.terraform_remote_state.networking.outputs.non_prod_vpc_self_link
  ]

  prod_perimeter_resources = concat(
    [for project_id in local.prod_projects_list : "projects/${data.google_project.prod_projects[project_id].number}"],

    [for project_id in keys(data.google_project.additional_projects) : "projects/${data.google_project.additional_projects[project_id].number}"],

    [
      for vpc_link in local.prod_vpc_list : replace(vpc_link,
        "https://www.googleapis.com/compute/v1",
        "//compute.googleapis.com"
      )
    ],

    [
      for vpc in data.google_compute_network.additional_vpcs : replace(vpc.self_link,
        "https://www.googleapis.com/compute/v1",
        "//compute.googleapis.com"
      )
    ]
  )

  non_prod_perimeter_resources = concat(
    [for project_id in local.non_prod_projects_list : "projects/${data.google_project.non_prod_projects[project_id].number}"],

    [
      for vpc_link in local.non_prod_vpc_list : replace(vpc_link,
        "https://www.googleapis.com/compute/v1",
        "//compute.googleapis.com"
      )
    ]
  )

  prod_perimeters_map = {
    for name, config in var.vpc_sc_configs["prod_config"].perimeters : name => {
      title                     = config.title
      use_explicit_dry_run_spec = config.use_explicit_dry_run_spec

      spec = config.use_explicit_dry_run_spec ? merge(
        config.spec,
        {
          resources           = local.prod_perimeter_resources
          restricted_services = local.all_vpc_sc_services
          vpc_accessible_services = {
            allowed_services   = local.all_vpc_sc_services
            enable_restriction = true
          }
        }
      ) : null

      status = !config.use_explicit_dry_run_spec ? merge(
        config.status,
        {
          resources           = local.prod_perimeter_resources
          restricted_services = local.all_vpc_sc_services
          vpc_accessible_services = {
            allowed_services   = local.all_vpc_sc_services
            enable_restriction = true
          }
        }
      ) : null
    }
  }

  #   non_prod_perimeters_map = {
  #     for name, config in var.vpc_sc_configs["dev_config"].perimeters : name => {
  #       title                     = config.title
  #       use_explicit_dry_run_spec = config.use_explicit_dry_run_spec

  #       spec = config.use_explicit_dry_run_spec ? merge(
  #         config.spec,
  #         {
  #           resources           = local.non_prod_perimeter_resources
  #           restricted_services = local.all_vpc_sc_services
  #           vpc_accessible_services = {
  #             allowed_services   = local.all_vpc_sc_services
  #             enable_restriction = true
  #           }
  #         }
  #       ) : null

  #       status = !config.use_explicit_dry_run_spec ? merge(
  #         config.status,
  #         {
  #           resources           = local.non_prod_perimeter_resources
  #           restricted_services = local.all_vpc_sc_services
  #           vpc_accessible_services = {
  #             allowed_services   = local.all_vpc_sc_services
  #             enable_restriction = true
  #           }
  #         }
  #       ) : null
  #     }
  #   }

  all_vpc_sc_services = jsondecode(data.external.vpc_sc_services_json.result.services)
}