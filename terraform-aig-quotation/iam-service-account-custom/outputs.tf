output "service_account_email" {
  value = module.hub_iam_service_account.service_account_email
}

output "hub_service_account_custom_role_names" {
  description = "The full names of the created custom IAM roles."
  value = {
    for key, role in module.hub_iam_service_account.iam_custom_roles : key => role.name
  }
}

output "hub_service_account_custom_role_ids" {
  description = "The short IDs of the created custom IAM roles."
  value       = keys(module.hub_iam_service_account.iam_custom_roles)
}