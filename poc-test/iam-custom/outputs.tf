# -----------------------------------------------------------------------------
# OUTPUTS
# -----------------------------------------------------------------------------

output "custom_role_names" {
  description = "The full names of the created custom IAM roles."
  value = {
    for key, role in google_organization_iam_custom_role.custom_roles : key => role.name
  }
}

output "custom_role_ids" {
  description = "The short IDs of the created custom IAM roles."
  value       = keys(google_organization_iam_custom_role.custom_roles)
}