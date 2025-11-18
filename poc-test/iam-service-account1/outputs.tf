# # outputs.tf

# output "service_account_email" {
#   description = "The email of the created service account."
#   value       = google_service_account.custom_sa.email
# }

# output "custom_role_name" {
#   description = "The full name of the organization custom role (e.g., organizations/ORG_ID/roles/ROLE_ID)."
#   value       = google_organization_iam_custom_role.custom_role.name
# }