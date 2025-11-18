output "project_id_map" {
  value = local.project_id_map
}

output "included_projects_list" {
  value = local.included_projects_list
}

output "vpc_networks_map" {
  value = local.vpc_networks_map
}

output "included_vpcs" {
  value = local.included_vpcs
}

output "perimeter_resources" {
  value = local.perimeter_resources
}


output "services" {
  value = data.external.vpc_sc_services_json.result.service_names_json
}