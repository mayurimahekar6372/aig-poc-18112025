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
  unique_predefined_roles = toset(flatten(values(var.service_custom_roles)))

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

resource "google_service_account" "service_accounts" {
  for_each     = var.service_accounts
  project      = var.project_id
  account_id   = each.key
  display_name = each.value
}

# Create each custom IAM role at the project level.
resource "google_project_iam_custom_role" "custom_roles" {
  for_each = var.service_custom_roles

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

# resource "google_project_iam_member" "sa_custom_role_bindings" {
#   # Flatten the input structure to create one resource instance per (role_id, service_account_id) pair.
#   # Assuming var.sa_role_bindings is a map where:
#   # Key = custom_role_id (e.g., "org_admin_data_reader")
#   # Value = list of service_account_ids (e.g., ["my-data-reader-sa", "another-sa"])
#   for_each = {
#     for pair in flatten([
#       for role_id, sa_ids in var.sa_role_bindings : [
#         for sa_id in sa_ids : {
#           role_id = role_id
#           sa_id   = sa_id
#         }
#       ]
#     ]) : "${pair.role_id}-${pair.sa_id}" => pair
#   }

#   project = var.project_id

#   # Reference the custom role using its full organization-level name.
#   # It is the same role created earlier: google_organization_iam_custom_role.custom_roles.
#   role   = google_project_iam_custom_role.custom_roles[each.value.role_id].id

#   # The member format for a service account is 'serviceAccount:EMAIL_ADDRESS'.
#   # The email is an attribute of the created service account resource.
#   member = "serviceAccount:${google_service_account.service_accounts[each.value.sa_id].email}"
# }

# resource "google_project_iam_member" "custom_role_bindings" {
#   # The for_each logic remains the same, assuming var.project_role_bindings 
#   # (or similar) is a map(list(string)) structure.
#   for_each = {
#     for pair in flatten([
#       for role_id, members in var.custom_role_bindings : [ # Assumes variable named 'project_role_bindings'
#         for member in members : {
#           role_id = role_id
#           member  = member
#         }
#       ]
#     ]) : "${pair.role_id}-${pair.member}" => pair
#   }

#   project = var.project_id

#   # FIX: Reference the custom role using the 'id' attribute of the 
#   # google_project_iam_custom_role resource, which provides the full 
#   # resource name: projects/{project_id}/roles/{role_id}
#   role = google_project_iam_custom_role.custom_roles[each.value.role_id].id

#   member = each.value.member
# }

resource "google_project_iam_member" "sa_custom_role_bindings" {
  # This 'for_each' will create a binding for every combination of 
  # created custom role and created service account.
  for_each = {
    for pair in flatten([
      # Iterate over every created custom role
      for role_id, role in google_project_iam_custom_role.custom_roles : [
        # And for each role, iterate over every created service account
        for sa_id, sa in google_service_account.service_accounts : {
          role_id = role_id
          sa_id   = sa_id
        }
      ]
    ]) : "${pair.role_id}-${pair.sa_id}" => pair
  }

  project = var.project_id

  # The role reference uses the created custom role's ID
  role = google_project_iam_custom_role.custom_roles[each.value.role_id].id

  # The member reference uses the created service account's email
  member = "serviceAccount:${google_service_account.service_accounts[each.value.sa_id].email}"
}