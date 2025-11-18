# module "hub_network_project" {
#   source          = "../modules/project"
#   billing_account = var.billing_account
#   name            = var.project_details["hub-network"].name
#   prefix          = var.project_details["hub-network"].prefix
#   parent          = data.terraform_remote_state.folders.outputs.hub_network_folder_id
#   labels          = var.project_details["hub-network"].labels
# }

# module "hub_project_apis" {
#   source                     = "../modules/api-enablement"
#   project_id                 = module.hub_network_project.project_id
#   services                   = var.project_details["hub-network"].services
#   disable_on_destroy         = true
#   disable_dependent_services = true
# }

# module "non_prod_host_project" {
#   source          = "../modules/project"
#   billing_account = var.billing_account
#   name            = var.project_details["non-prod-host"].name
#   prefix          = var.project_details["non-prod-host"].prefix
#   parent          = data.terraform_remote_state.folders.outputs.non_prod_host_folder_id
#   labels          = var.project_details["non-prod-host"].labels
# }

# module "non_prod_host_project_apis" {
#   source                     = "../modules/api-enablement"
#   project_id                 = module.non_prod_host_project.project_id
#   services                   = var.project_details["non-prod-host"].services
#   disable_on_destroy         = true
#   disable_dependent_services = true
# }

# module "non_prod_service_project" {
#   source          = "../modules/project"
#   billing_account = var.billing_account
#   name            = var.project_details["non-prod-service"].name
#   prefix          = var.project_details["non-prod-service"].prefix
#   parent          = data.terraform_remote_state.folders.outputs.non_prod_service_folder_id
#   labels          = var.project_details["non-prod-service"].labels
# }

# module "non_prod_service_project_apis" {
#   source                     = "../modules/api-enablement"
#   project_id                 = module.non_prod_service_project.project_id
#   services                   = var.project_details["non-prod-service"].services
#   disable_on_destroy         = true
#   disable_dependent_services = true
# }

# module "gi_japan_sonpo_non_prod_project" {
#   source          = "../modules/project"
#   billing_account = var.billing_account
#   name            = var.project_details["gi-japan-sonpo-non-prod-service"].name
#   prefix          = var.project_details["gi-japan-sonpo-non-prod-service"].prefix
#   parent          = data.terraform_remote_state.folders.outputs.gi_japan_non_prod_folder_id
#   labels          = var.project_details["gi-japan-sonpo-non-prod-service"].labels
# }

# module "gi_japan_sonpo_non_prod_project_apis" {
#   source                     = "../modules/api-enablement"
#   project_id                 = module.gi_japan_sonpo_non_prod_project.project_id
#   services                   = var.project_details["gi-japan-sonpo-non-prod-service"].services
#   disable_on_destroy         = true
#   disable_dependent_services = true
# }

# module "gi_japan_ah_non_prod_project" {
#   source          = "../modules/project"
#   billing_account = var.billing_account
#   name            = var.project_details["gi-japan-ah-non-prod-service"].name
#   prefix          = var.project_details["gi-japan-ah-non-prod-service"].prefix
#   parent          = data.terraform_remote_state.folders.outputs.gi_japan_non_prod_folder_id
#   labels          = var.project_details["gi-japan-ah-non-prod-service"].labels
# }

# module "gi_japan_ah_non_prod_project_apis" {
#   source                     = "../modules/api-enablement"
#   project_id                 = module.gi_japan_ah_non_prod_project.project_id
#   services                   = var.project_details["gi-japan-ah-non-prod-service"].services
#   disable_on_destroy         = true
#   disable_dependent_services = true
# }

# module "logging_bucket_project" {
#   source          = "../modules/project"
#   billing_account = var.billing_account
#   name            = var.project_details["logging-bucket-prj"].name
#   prefix          = var.project_details["logging-bucket-prj"].prefix
#   parent          = data.terraform_remote_state.folders.outputs.hub_network_folder_id
#   labels          = var.project_details["logging-bucket-prj"].labels
# }

# module "logging_bucket_project_apis" {
#   source                     = "../modules/api-enablement"
#   project_id                 = module.logging_bucket_project.project_id
#   services                   = var.project_details["logging-bucket-prj"].services
#   disable_on_destroy         = true
#   disable_dependent_services = true
# }


##Enhancement

module "projects" {
  source          = "../modules/project"
  for_each        = var.project_details
  
  billing_account = var.billing_account
  name            = each.value.name
  prefix          = each.value.prefix
  labels          = each.value.labels
  parent          = data.terraform_remote_state.folders.outputs[each.value.parent_output_key]
}

module "project_apis" {
  source                       = "../modules/api-enablement"

  for_each                     = var.project_details
  project_id                   = module.projects[each.key].project_id 
  services                     = each.value.services
  disable_on_destroy           = true
  disable_dependent_services   = true
}