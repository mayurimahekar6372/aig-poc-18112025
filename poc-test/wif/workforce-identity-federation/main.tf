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
# FIX 1: Corrected google_iam_workforce_pool resource
# -----------------------------------------------------------------
resource "google_iam_workforce_pool" "pool" {
  provider = google

  # 'parent' is required and must be an organization ID
  parent = "organizations/${var.organization_id}"
  
  # 'workforce_pool_id' is the correct argument, not 'pool_id'
  workforce_pool_id = var.pool_id
  
  # 'location' is required and must be "global"
  location = "global"
  
  display_name = var.pool_display_name
  description  = "Workforce pool for Okta SAML"
  disabled     = false
}

# # -----------------------------------------------------------------
# # FIX 2: Corrected google_iam_workforce_pool_provider resource
# # -----------------------------------------------------------------
# resource "google_iam_workforce_pool_provider" "okta_provider" {
#   provider = google

#   # This resource correctly uses 'workforce_pool_id' to link to the pool
#   workforce_pool_id = google_iam_workforce_pool.pool.workforce_pool_id
  
#   # 'provider_id' is the ID you are assigning to this provider
#   provider_id = var.provider_id
  
#   # 'location' is required and must be "global"
#   location = "global"

#   display_name = var.provider_display_name
#   description  = "SAML 2.0 provider for Okta"

#   saml {
#     idp_metadata_xml = file(var.saml_metadata_xml_path)
#   }

#   attribute_mapping = var.attribute_mapping
# }

# # -----------------------------------------------------------------
# # NO CHANGE: This resource is correct, as IAM bindings
# # ARE applied at the project level.
# # -----------------------------------------------------------------
# resource "google_project_iam_member" "group_bindings" {
#   for_each = { for binding in local.iam_bindings_flat : "${binding.role}---${binding.group}" => binding }

#   provider = google
#   project  = var.project_id # This is correct
#   role     = each.value.role
  
#   # This interpolation is also correct
#   member   = "principalSet://iam.googleapis.com/workforcePools/${google_iam_workforce_pool.pool.workforce_pool_id}/group/${each.value.group}"
# }