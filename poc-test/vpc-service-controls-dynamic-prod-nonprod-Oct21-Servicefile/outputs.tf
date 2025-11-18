output "org_project_list" {
  value = local.org_project_list
}

output "prod_projects_list" {
  value = local.prod_projects_list
}

output "non_prod_projects_list" {
  value = local.non_prod_projects_list
}

output "org_vpc_networks_list" {
  value = local.org_vpc_networks_list
}

output "prod_vpcs_list" {
  value = local.prod_vpcs_list
}

output "non_prod_vpcs_list" {
  value = local.non_prod_vpcs_list
}

output "access_policy" {
  value = module.vpc_access_policy.id
}