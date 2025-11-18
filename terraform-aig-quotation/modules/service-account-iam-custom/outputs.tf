output "service_account_email" {
  description = "A map of created Service Account IDs to their email address and display name."
  value = {
    # Iterate over the map of created service account resources
    for sa_id, sa in google_service_account.service_accounts : sa_id => {
      email = sa.email
    }
  }
}

output "iam_custom_roles" {
  value = google_project_iam_custom_role.custom_roles
}