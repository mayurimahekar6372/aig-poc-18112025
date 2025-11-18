# terraform {
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = ">= 5.0"
#     }
#   }
# }

# provider "google" {
#   project = var.gcp_project_id
# }

# # Enable necessary APIs for workforce federation
# resource "google_project_service" "iam" {
#   service = "iam.googleapis.com"
# }

# resource "google_project_service" "sts" {
#   service = "sts.googleapis.com"
# }

# Call the reusable module to create the federation setup
module "okta_federation" {
  #   source = "./modules/gcp-workforce-okta-saml"
  source          = "./modules"
  organization_id = var.organization_id
  # Pass variables from our root .tfvars file to the module
  #   project_id               = var.gcp_project_id
  #   saml_metadata_xml_path   = var.okta_metadata_file
  #   group_iam_bindings       = var.okta_group_permissions

  # You can also override defaults here if needed
  pool_id = "my-custom-pool-id"
}