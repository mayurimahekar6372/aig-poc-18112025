output "org_custom_role_names" {
  description = "The full names of the created custom IAM roles."
  value = {
    for key, role in module.org_custom_iam_role.iam_custom_roles : key => role.name
  }
}

output "org_custom_role_ids" {
  description = "The short IDs of the created custom IAM roles."
  value       = keys(module.org_custom_iam_role.iam_custom_roles)
}

output "hub_project_custom_role_names" {
  description = "The full names of the created custom IAM roles."
  value = {
    for key, role in module.hub_project_iam_custom_role.iam_custom_roles : key => role.name
  }
}

output "hub_project_custom_role_ids" {
  description = "The short IDs of the created custom IAM roles."
  value       = keys(module.hub_project_iam_custom_role.iam_custom_roles)
}

output "non_prod_host_project_custom_role_names" {
  description = "The full names of the created custom IAM roles."
  value = {
    for key, role in module.non_prod_host_project_iam_custom_role.iam_custom_roles : key => role.name
  }
}

output "non_prod_host_project_custom_role_ids" {
  description = "The short IDs of the created custom IAM roles."
  value       = keys(module.non_prod_host_project_iam_custom_role.iam_custom_roles)
}