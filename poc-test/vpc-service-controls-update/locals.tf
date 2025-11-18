locals {
  project_id_map = {
    for result in data.google_cloud_asset_search_all_resources.projects.results :
    trimprefix(result.name, "//cloudresourcemanager.googleapis.com/projects/") =>
    result.project
  }

  included_projects_list = {
    for id, number in local.project_id_map : id => number
    if !contains(var.excluded_projects, id)
  }

  vpc_networks_map = {
    for result in data.google_cloud_asset_search_all_resources.vpc_networks.results :
    result.display_name => result.name
  }

  included_vpcs = {
    for name, link in local.vpc_networks_map : name => link
    if !contains(var.excluded_vpcs, name)
  }

  perimeter_resources = concat(values(local.included_projects_list), values(local.included_vpcs))

  vpc_sc_services = jsondecode(data.external.vpc_sc_services_json.result.services)

  perimeters_map = {
    for name, config in var.vpc_sc_configs["prod_config"].perimeters : name => {
      title                     = config.title
      use_explicit_dry_run_spec = config.use_explicit_dry_run_spec

      spec = config.use_explicit_dry_run_spec ? merge(
        config.spec,
        {
          resources           = local.perimeter_resources
          restricted_services = local.vpc_sc_services
          vpc_accessible_services = {
            allowed_services   = local.vpc_sc_services
            enable_restriction = true
          }
        }
      ) : null

      status = !config.use_explicit_dry_run_spec ? merge(
        config.status,
        {
          resources           = local.perimeter_resources
          restricted_services = local.vpc_sc_services
          vpc_accessible_services = {
            allowed_services   = local.vpc_sc_services
            enable_restriction = true
          }
        }
      ) : null
    }
  }
}





################################## Dynamic Block ###########################################

# locals {
#   # Existing logic to map Google Cloud projects by ID
#   project_id_map = {
#     for result in data.google_cloud_asset_search_all_resources.projects.results :
#     trimprefix(result.name, "//cloudresourcemanager.googleapis.com/projects/") =>
#     result.project
#   }

#   included_projects_list = {
#     for id, number in local.project_id_map : id => number
#     if !contains(var.excluded_projects, id)
#   }

#   # Existing logic to map VPC networks
#   vpc_networks_map = {
#     for result in data.google_cloud_asset_search_all_resources.vpc_networks.results :
#     result.display_name => result.name
#   }

#   included_vpcs = {
#     for name, link in local.vpc_networks_map : name => link
#     if !contains(var.excluded_vpcs, name)
#   }

#   perimeter_resources = concat(values(local.included_projects_list), values(local.included_vpcs))

#   vpc_sc_services = jsondecode(data.external.vpc_sc_services_json.result.services)

#   # --- Dynamic Selection: Selects the active configuration based on a variable ---
#   # 'var.active_config_key' must be provided (e.g., "prod_config" or "staging_config")
#   active_vpc_sc_config = var.vpc_sc_configs[var.active_config_key]

#   # Now iterating over the perimeters defined in the dynamically selected configuration
#   perimeters_map = {
#     for name, config in local.active_vpc_sc_config.perimeters : name => {
#       title                     = config.title
#       use_explicit_dry_run_spec = config.use_explicit_dry_run_spec

#       # Logic for 'spec' (Dry Run configuration)
#       spec = config.use_explicit_dry_run_spec ? merge(
#         config.spec,
#         {
#           resources             = local.perimeter_resources
#           restricted_services   = local.vpc_sc_services
#           vpc_accessible_services = {
#             allowed_services   = local.vpc_sc_services
#             enable_restriction = true
#           }
#         }
#       ) : null

#       # Logic for 'status' (Enforced configuration)
#       status = !config.use_explicit_dry_run_spec ? merge(
#         config.status,
#         {
#           resources             = local.perimeter_resources
#           restricted_services   = local.vpc_sc_services
#           vpc_accessible_services = {
#             allowed_services   = local.vpc_sc_services
#             enable_restriction = true
#           }
#         }
#       ) : null
#     }
#   }
# }



################################################# Dunamic Block ################################