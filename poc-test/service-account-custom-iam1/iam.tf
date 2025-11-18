# -----------------------------------------------------------------------------
# DATA SOURCES & LOCALS
# -----------------------------------------------------------------------------

# locals {
#   # Create a flat, unique set of all predefined roles needed across all custom roles.
#   # This avoids duplicate data source lookups and improves performance.
#   unique_predefined_roles = toset(flatten(values(var.custom_roles)))
# }

locals {
  # Create a flat, unique set of all predefined roles needed across all custom roles.
  unique_predefined_roles = toset(flatten(values(var.custom_roles)))

  # Combine default and user-provided excluded permissions into a single set for filtering
  all_excluded_permissions = toset(distinct(concat(var.default_excluded_permissions, var.excluded_permissions)))
}

# Fetch the details (including all permissions) for each unique predefined role.
data "google_iam_role" "predefined_roles" {
  for_each = local.unique_predefined_roles
  name     = each.key
}

# -----------------------------------------------------------------------------
# RESOURCES
# -----------------------------------------------------------------------------

# Create each custom IAM role at the project level.
resource "google_project_iam_custom_role" "custom_roles" {
  for_each = var.custom_roles

  # Use the project ID variable instead of org_id
  project     = var.project_id
  role_id     = each.key
  title       = title(replace(each.key, "_", " "))
  description = "Custom role for ${title(replace(each.key, "_", " "))} responsibilities."

  # # For each predefined role associated with this custom role (from the input variable),
  # # look up its permissions from the data source and merge them all into one unique set.
  # permissions = toset(flatten([
  #   for predefined_role in each.value : data.google_iam_role.predefined_roles[predefined_role].included_permissions
  # ]))

  # Filtered permissions list to prevent the "Permission is not valid" error.
  permissions = toset(compact(flatten([
    for predefined_role in each.value : [
      for permission in data.google_iam_role.predefined_roles[predefined_role].included_permissions :
      # Check if the permission is in the exclusion list.
      # If it is in the exclusion list, return null. Otherwise, return the permission.
      contains(local.all_excluded_permissions, permission) ? null : permission
    ]
  ])))
}

resource "google_project_iam_binding" "service_account_iam_binding" {
  for_each = var.custom_roles
  project = var.project_id
  # role    = google_project_iam_custom_role.custom_roles.id
  role    = google_project_iam_custom_role.custom_roles[each.key].name
  members = [
    "serviceAccount:${local.service_account.email}"
  ]
}