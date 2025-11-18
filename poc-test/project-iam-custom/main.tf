# locals {
#   # Create a flat, unique set of all predefined roles needed across all custom roles.
#   unique_predefined_roles = toset(flatten(values(var.custom_roles)))

#   # Combine default and user-provided excluded permissions into a single set for filtering
#   all_excluded_permissions = toset(distinct(concat(var.default_excluded_permissions, var.excluded_permissions)))
# }

locals {
  # 1. Separate all input strings into either a predefined role or an individual permission.
  custom_roles = toset(flatten(values(var.custom_roles)))

  # Filter out the predefined roles (strings starting with "roles/")
  unique_predefined_roles = toset([
    for s in local.custom_roles : s
    if can(regex("^roles/", s))
  ])

  # Filter out the individual permissions (strings NOT starting with "roles/")
  unique_individual_permissions = toset([
    for s in local.custom_roles : s
    if !can(regex("^roles/", s))
  ])

  # Combine default and user-provided excluded permissions into a single set for filtering
  all_excluded_permissions = toset(distinct(concat(var.default_excluded_permissions, var.excluded_permissions)))
}

# Fetch the details (including all permissions) for each unique predefined role.
data "google_iam_role" "predefined_roles" {
  for_each = local.unique_predefined_roles
  name     = each.key
}

# Create each custom IAM role at the project level.
resource "google_project_iam_custom_role" "custom_roles" {
  for_each = var.custom_roles

  # Use the project ID variable instead of org_id
  project     = var.project_id
  role_id     = each.key
  title       = title(replace(each.key, "_", " "))
  description = "Custom role for ${title(replace(each.key, "_", " "))} responsibilities."

  # Filtered permissions list to prevent the "Permission is not valid" error.
  # permissions = toset(compact(flatten([
  #   for predefined_role in each.value : [
  #     for permission in data.google_iam_role.predefined_roles[predefined_role].included_permissions :
  #     # Check if the permission is in the exclusion list.
  #     # If it is in the exclusion list, return null. Otherwise, return the permission.
  #     contains(local.all_excluded_permissions, permission) ? null : permission
  #   ]
  # ])))

  permissions = toset(compact(flatten([
    for input_string in each.value :
      # Check if the input string is a predefined role ID (starts with roles/)
      can(regex("^roles/", input_string)) ? (
        # True Result: A LIST/TUPLE of filtered permissions from the role
        [
          for permission in data.google_iam_role.predefined_roles[input_string].included_permissions :
          # Check for exclusion
          contains(local.all_excluded_permissions, permission) ? null : permission
        ]
      ) : (
        # False Result: Must also be a LIST/TUPLE. Wrap the single permission result in a list.
        [
          # If it is NOT a role, treat it as a raw permission and filter it
          contains(local.all_excluded_permissions, input_string) ? null : input_string
        ]
      )
  ])))
}

resource "google_project_iam_member" "custom_role_bindings" {
  for_each = {
    for pair in flatten([
      for role_id, members in var.custom_role_bindings : [ # Assumes variable named 'project_role_bindings'
        for member in members : {
          role_id = role_id
          member  = member
        }
      ]
    ]) : "${pair.role_id}-${pair.member}" => pair
  }

  project = var.project_id

  # google_project_iam_custom_role resource, which provides the full 
  # resource name: projects/{project_id}/roles/{role_id}
  role = google_project_iam_custom_role.custom_roles[each.value.role_id].id

  member = each.value.member
}