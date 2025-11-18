locals {
  org_project_list = {
    for result in data.google_cloud_asset_search_all_resources.projects.results :
    trimprefix(result.name, "//cloudresourcemanager.googleapis.com/projects/") =>
    result.project
  }

  prod_projects_list = {
    for id, number in local.org_project_list : id => number
    if !contains(var.exclude_nprod_projects, id)
  }

  non_prod_projects_list = {
    for id, number in local.org_project_list : id => number
    if !contains(var.exclude_prod_projects, id)
  }

  org_vpc_networks_list = {
    for result in data.google_cloud_asset_search_all_resources.vpc_networks.results :
    result.display_name => result.name
  }

  prod_vpcs_list = {
    for name, link in local.org_vpc_networks_list : name => link
    if !contains(var.exclude_nprod_vpcs, name)
  }

  non_prod_vpcs_list = {
    for name, link in local.org_vpc_networks_list : name => link
    if !contains(var.exclude_prod_vpcs, name)
  }

  prod_perimeter_resources     = concat(values(local.prod_projects_list), values(local.prod_vpcs_list))
  non_prod_perimeter_resources = concat(values(local.non_prod_projects_list), values(local.non_prod_vpcs_list))

  vpc_sc_services = jsondecode(data.external.vpc_sc_services_json.result.service_names_json)

  # prod_perimeters_map = {
  #   for p in flatten([
  #     for config_key, config_value in var.vpc_sc_configs :
  #     [
  #       for perimeter_name, perimeter_config in config_value.perimeters : {
  #         key                       = "${config_key}_${perimeter_name}"
  #         title                     = perimeter_config.title
  #         use_explicit_dry_run_spec = perimeter_config.use_explicit_dry_run_spec

  #         spec = perimeter_config.use_explicit_dry_run_spec ? merge(
  #           perimeter_config.spec,
  #           {
  #             resources           = local.prod_projects_vpcs # Adjust as needed
  #             restricted_services = local.vpc_sc_services
  #             vpc_accessible_services = {
  #               allowed_services   = local.vpc_sc_services
  #               enable_restriction = true
  #             }
  #           }
  #         ) : null

  #         status = !perimeter_config.use_explicit_dry_run_spec ? merge(
  #           perimeter_config.status,
  #           {
  #             resources           = local.prod_projects_vpcs # Adjust as needed
  #             restricted_services = local.vpc_sc_services
  #             vpc_accessible_services = {
  #               allowed_services   = local.vpc_sc_services
  #               enable_restriction = true
  #             }
  #           }
  #         ) : null
  #       }
  #     ]
  #   ]) : p.key => p
  # }

  # non_prod_perimeters_map = {
  #   for p in flatten([
  #     for config_key, config_value in var.vpc_sc_configs :
  #     [
  #       for perimeter_name, perimeter_config in config_value.perimeters : {
  #         key                       = "${config_key}_${perimeter_name}"
  #         title                     = perimeter_config.title
  #         use_explicit_dry_run_spec = perimeter_config.use_explicit_dry_run_spec

  #         spec = perimeter_config.use_explicit_dry_run_spec ? merge(
  #           perimeter_config.spec,
  #           {
  #             resources           = local.non_prod_projects_vpcs # Adjust as needed
  #             restricted_services = local.vpc_sc_services
  #             vpc_accessible_services = {
  #               allowed_services   = local.vpc_sc_services
  #               enable_restriction = true
  #             }
  #           }
  #         ) : null

  #         status = !perimeter_config.use_explicit_dry_run_spec ? merge(
  #           perimeter_config.status,
  #           {
  #             resources           = local.non_prod_projects_vpcs # Adjust as needed
  #             restricted_services = local.vpc_sc_services
  #             vpc_accessible_services = {
  #               allowed_services   = local.vpc_sc_services
  #               enable_restriction = true
  #             }
  #           }
  #         ) : null
  #       }
  #     ]
  #   ]) : p.key => p
  # }

  # prod_config_keys     = lookup(var.vpc_sc_config_environments, "prod", [])
  # non_prod_config_keys = lookup(var.vpc_sc_config_environments, "non_prod", [])

  policy_id = "accessPolicies/${module.vpc_access_policy.id}"
  #   prod_perimeters_map = {
  #     for p in flatten([
  #       for config_key, config_value in var.vpc_sc_configs :
  #       [
  #         for perimeter_name, perimeter_config in config_value.perimeters : {
  #           key                       = "${config_key}_${perimeter_name}"
  #           title                     = perimeter_config.title
  #           use_explicit_dry_run_spec = perimeter_config.use_explicit_dry_run_spec

  #           # FIX: Rebuild 'spec' block, replacing short Access Level names with canonical names
  #           spec = perimeter_config.use_explicit_dry_run_spec ? merge(
  #             perimeter_config.spec,
  #             {
  #               resources           = local.prod_projects_vpcs
  #               restricted_services = local.vpc_sc_services
  #               vpc_accessible_services = {
  #                 allowed_services  = local.vpc_sc_services
  #                 enable_restriction = true
  #               }
  #               # *** THE CRITICAL FIX: Canonicalize Access Level names ***
  #               access_levels = [
  #                 for short_name in lookup(perimeter_config.spec, "access_levels", []) :
  #                 "${local.policy_id}/accessLevels/${short_name}"
  #               ]
  #             }
  #           ) : null

  #           # FIX: Rebuild 'status' block, replacing short Access Level names with canonical names
  #           status = !perimeter_config.use_explicit_dry_run_spec ? merge(
  #             perimeter_config.status,
  #             {
  #               resources           = local.prod_projects_vpcs
  #               restricted_services = local.vpc_sc_services
  #               vpc_accessible_services = {
  #                 allowed_services  = local.vpc_sc_services
  #                 enable_restriction = true
  #               }
  #               # *** THE CRITICAL FIX: Canonicalize Access Level names ***
  #               access_levels = [
  #                 for short_name in lookup(perimeter_config.status, "access_levels", []) :
  #                 "${local.policy_id}/accessLevels/${short_name}"
  #               ]
  #             }
  #           ) : null
  #         }
  #       ]
  #     ]) : p.key => p
  #     if startswith(p.key, "prod_sc") # Filter for only the 'prod_sc' configuration keys
  #   }

  #   # ----------------------------------------------------------------------------------
  #   # NEW/MODIFIED LOGIC for non_prod_perimeters_map
  #   # ----------------------------------------------------------------------------------
  #   non_prod_perimeters_map = {
  #     for p in flatten([
  #       for config_key, config_value in var.vpc_sc_configs :
  #       [
  #         for perimeter_name, perimeter_config in config_value.perimeters : {
  #           key                       = "${config_key}_${perimeter_name}"
  #           title                     = perimeter_config.title
  #           use_explicit_dry_run_spec = perimeter_config.use_explicit_dry_run_spec

  #           # FIX: Rebuild 'spec' block, replacing short Access Level names with canonical names
  #           spec = perimeter_config.use_explicit_dry_run_spec ? merge(
  #             perimeter_config.spec,
  #             {
  #               resources           = local.non_prod_projects_vpcs
  #               restricted_services = local.vpc_sc_services
  #               vpc_accessible_services = {
  #                 allowed_services  = local.vpc_sc_services
  #                 enable_restriction = true
  #               }
  #               # *** THE CRITICAL FIX: Canonicalize Access Level names ***
  #               access_levels = [
  #                 for short_name in lookup(perimeter_config.spec, "access_levels", []) :
  #                 "${local.policy_id}/accessLevels/${short_name}"
  #               ]
  #             }
  #           ) : null

  #           # FIX: Rebuild 'status' block, replacing short Access Level names with canonical names
  #           status = !perimeter_config.use_explicit_dry_run_spec ? merge(
  #             perimeter_config.status,
  #             {
  #               resources           = local.non_prod_projects_vpcs
  #               restricted_services = local.vpc_sc_services
  #               vpc_accessible_services = {
  #                 allowed_services  = local.vpc_sc_services
  #                 enable_restriction = true
  #               }
  #               # *** THE CRITICAL FIX: Canonicalize Access Level names ***
  #               access_levels = [
  #                 for short_name in lookup(perimeter_config.status, "access_levels", []) :
  #                 "${local.policy_id}/accessLevels/${short_name}"
  #               ]
  #             }
  #           ) : null
  #         }
  #       ]
  #     ]) : p.key => p
  #     # if startswith(p.key, "nprod_sc_") # Filter for only the 'nprod_sc' configuration keys
  #   }

  prod_perimeters_map = {
    for name, config in var.vpc_sc_configs["prod_config"].perimeters : name => {
      title                     = config.title
      use_explicit_dry_run_spec = config.use_explicit_dry_run_spec

      spec = config.use_explicit_dry_run_spec ? merge(
        config.spec,
        {
          resources           = local.prod_perimeter_resources
          restricted_services = local.vpc_sc_services
          vpc_accessible_services = {
            allowed_services   = local.vpc_sc_services
            enable_restriction = true
          }
          access_levels = [
            for short_name in lookup(config.spec, "access_levels", []) :
            "${local.policy_id}/accessLevels/${short_name}"
          ]
        }
      ) : null

      status = !config.use_explicit_dry_run_spec ? merge(
        config.status,
        {
          resources           = local.prod_perimeter_resources
          restricted_services = local.vpc_sc_services
          vpc_accessible_services = {
            allowed_services   = local.vpc_sc_services
            enable_restriction = true
          }
          access_levels = [
            for short_name in lookup(config.status, "access_levels", []) :
            "${local.policy_id}/accessLevels/${short_name}"
          ]
        }
      ) : null
    }
  }

  non_prod_perimeters_map = {
    for name, config in var.vpc_sc_configs["non_prod_config"].perimeters : name => {
      title                     = config.title
      use_explicit_dry_run_spec = config.use_explicit_dry_run_spec

      spec = config.use_explicit_dry_run_spec ? merge(
        config.spec,
        {
          resources           = local.non_prod_perimeter_resources
          restricted_services = local.vpc_sc_services
          vpc_accessible_services = {
            allowed_services   = local.vpc_sc_services
            enable_restriction = true
          }
          access_levels = [
            for short_name in lookup(config.spec, "access_levels", []) :
            "${local.policy_id}/accessLevels/${short_name}"
          ]
        }
      ) : null

      status = !config.use_explicit_dry_run_spec ? merge(
        config.status,
        {
          resources           = local.non_prod_perimeter_resources
          restricted_services = local.vpc_sc_services
          vpc_accessible_services = {
            allowed_services   = local.vpc_sc_services
            enable_restriction = true
          }
          access_levels = [
            for short_name in lookup(config.status, "access_levels", []) :
            "${local.policy_id}/accessLevels/${short_name}"
          ]
        }
      ) : null
    }
  }
}