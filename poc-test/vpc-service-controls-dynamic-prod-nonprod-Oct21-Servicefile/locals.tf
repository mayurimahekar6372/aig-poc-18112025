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

  # vpc_sc_services = jsondecode(data.external.vpc_sc_services_json.result.service_names_json)
  vpc_sc_services = jsondecode(data.local_file.vpc_sc_services.content)

  policy_id = "accessPolicies/${module.vpc_access_policy.id}"

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