# -----------------------------------------------------------------------------
# DATA SOURCES & LOCALS
# -----------------------------------------------------------------------------

locals {
  # Create a flat, unique set of all predefined roles needed across all custom roles.
  # This avoids duplicate data source lookups and improves performance.
  unique_predefined_roles = toset(flatten(values(var.custom_roles)))
}

# Fetch the details (including all permissions) for each unique predefined role.
data "google_iam_role" "predefined_roles" {
  for_each = local.unique_predefined_roles
  name     = each.key
}

# -----------------------------------------------------------------------------
# RESOURCES
# -----------------------------------------------------------------------------

# Create each custom IAM role at the organization level.
resource "google_organization_iam_custom_role" "custom_roles" {
  for_each = var.custom_roles

  org_id      = var.organization_id
  role_id     = each.key
  title       = title(replace(each.key, "_", " "))
  description = "Custom role for ${title(replace(each.key, "_", " "))} responsibilities."

  # For each predefined role associated with this custom role (from the input variable),
  # look up its permissions from the data source and merge them all into one unique set.
  permissions = toset(flatten([
    for predefined_role in each.value : data.google_iam_role.predefined_roles[predefined_role].included_permissions
  ]))
}