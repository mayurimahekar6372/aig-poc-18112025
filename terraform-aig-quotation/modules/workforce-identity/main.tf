# This local block for flattening permissions is still correct
locals {
  iam_bindings_flat = flatten([
    for role, groups in var.group_iam_bindings : [
      for group in groups : {
        role  = role
        group = group
      }
    ]
  ])
}

# -----------------------------------------------------------------
# Workforce Pool Resource (ONLY created when create_pool_only is true)
# -----------------------------------------------------------------
resource "google_iam_workforce_pool" "pool" {
  count = var.create_pool_only ? 1 : 0

  provider          = google
  parent            = var.organization_id
  workforce_pool_id = var.pool_id
  location          = "global"
  display_name      = var.pool_display_name
  description       = "Workforce pool for Okta SAML"
  disabled          = false
}

# -----------------------------------------------------------------
# Workforce Pool Provider Resource (ONLY created when create_pool_only is false)
# -----------------------------------------------------------------
resource "google_iam_workforce_pool_provider" "okta_provider" {
  count = var.create_pool_only ? 0 : 1

  provider          = google
  workforce_pool_id = var.workforce_pool_id
  provider_id       = var.provider_id
  location          = "global"

  display_name = var.provider_display_name
  description  = "SAML 2.0 provider for Okta"

  saml {
    idp_metadata_xml = file(var.saml_metadata_xml_path)
  }

  attribute_mapping = var.attribute_mapping
}

# -----------------------------------------------------------------
# IAM Bindings Resource (ONLY created when create_pool_only is false)
# -----------------------------------------------------------------
resource "google_project_iam_member" "group_bindings" {
  for_each = var.create_pool_only ? {} : {
    for binding in local.iam_bindings_flat : "${binding.role}---${binding.group}" => binding
  }

  provider = google
  project  = var.project_id
  role     = each.value.role

  # Use the passed-in pool ID from the other module call
  member = "principalSet://iam.googleapis.com/workforcePools/${var.workforce_pool_id}/group/${each.value.group}"
}