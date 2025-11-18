
locals {
  saml_metadata_xml_path = "${path.module}/${var.okta_metadata_file}"
}

module "workforce_pool" {
  source            = "../modules/workforce-identity"
  create_pool_only  = true
  organization_id   = var.organization_id
  pool_id           = var.pool_id
  pool_display_name = var.pool_display_name
}


module "okta_federation_provider" {
  source = "../modules/workforce-identity"

  # CONTROL FLAG: Set to 'false' to skip the Pool, 'true' for Provider/IAM
  create_pool_only = false

  workforce_pool_id      = module.workforce_pool.workforce_pool_id
  provider_id            = var.provider_id
  provider_display_name  = var.provider_display_name
  saml_metadata_xml_path = local.saml_metadata_xml_path
  attribute_mapping      = var.attribute_mapping
  project_id             = data.terraform_remote_state.projects.outputs.hub_network_project_id
  # group_iam_bindings     = var.okta_group_permissions
}