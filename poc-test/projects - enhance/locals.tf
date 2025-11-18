# locals {
#   # This map should contain the key for the module instance, and all the 
#   # necessary information for that project's creation.
#   # We'll use the existing keys from var.project_details and enrich them 
#   # with the corresponding parent folder ID from the remote state.
#   project_configurations = {
#     "hub_network" = {
#       details   = var.project_details["hub-network"]
#       parent_id = data.terraform_remote_state.folders.outputs.hub_network_folder_id
#     }
#     "non_prod_host" = {
#       details   = var.project_details["non-prod-host"]
#       parent_id = data.terraform_remote_state.folders.outputs.non_prod_host_folder_id
#     }
#     "non_prod_service" = {
#       details   = var.project_details["non-prod-service"]
#       parent_id = data.terraform_remote_state.folders.outputs.non_prod_service_folder_id
#     }
#     "gi_japan_sonpo_non_prod" = {
#       details   = var.project_details["gi-japan-sonpo-non-prod-service"]
#       parent_id = data.terraform_remote_state.folders.outputs.gi_japan_non_prod_folder_id
#     }
#     "gi_japan_ah_non_prod" = {
#       details   = var.project_details["gi-japan-ah-non-prod-service"]
#       parent_id = data.terraform_remote_state.folders.outputs.gi_japan_non_prod_folder_id
#     }
#   }
# }