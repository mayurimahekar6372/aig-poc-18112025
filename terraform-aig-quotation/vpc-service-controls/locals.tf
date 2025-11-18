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

  # vpc_sc_services = jsondecode(data.external.vpc_sc_services_json.result.service_names_json)

  vpc_sc_services = jsondecode(data.local_file.vpc_sc_services.content)

  perimeters_map = {
    for p in flatten([
      for config_key, config_value in var.vpc_sc_configs :
      [
        for perimeter_name, perimeter_config in config_value.perimeters : { # Define the unique key before flattening
          key                       = "${config_key}_${perimeter_name}"
          title                     = perimeter_config.title
          use_explicit_dry_run_spec = perimeter_config.use_explicit_dry_run_spec

          spec = perimeter_config.use_explicit_dry_run_spec ? merge(
            perimeter_config.spec,
            {
              resources           = local.perimeter_resources # Adjust as needed
              restricted_services = local.vpc_sc_services
              vpc_accessible_services = {
                allowed_services   = local.vpc_sc_services
                enable_restriction = true
              }
            }
          ) : null

          status = !perimeter_config.use_explicit_dry_run_spec ? merge(
            perimeter_config.status,
            {
              resources           = local.perimeter_resources # Adjust as needed
              restricted_services = local.vpc_sc_services
              vpc_accessible_services = {
                allowed_services   = local.vpc_sc_services
                enable_restriction = true
              }
            }
          ) : null
        }
      ]
    ]) : p.key => p
  }
}