# output "hub_network_project_id" {
#   value = module.hub_network_project.project_id
# }

# output "non_prod_host_project_id" {
#   value = module.non_prod_host_project.project_id
# }

# output "non_prod_service_project_id" {
#   value = module.non_prod_service_project.project_id
# }

# output "gi_japan_sonpo_non_prod_project_id" {
#   value = module.gi_japan_sonpo_non_prod_project.project_id
# }

# output "gi_japan_ah_non_prod_project_id" {
#   value = module.gi_japan_ah_non_prod_project.project_id
# }

# output "logging_bucket_project_id" {
#   value = module.logging_bucket_project.project_id
# }


# --- In your outputs.tf file ---

output "hub_network_project_id" {
  # Reference the project using the key "hub-network" from var.project_details
  value = module.projects["hub-network"].project_id
}

output "non_prod_host_project_id" {
  # Reference the project using the key "non-prod-host"
  value = module.projects["non-prod-host"].project_id
}

output "non_prod_service_project_id" {
  # Reference the project using the key "non-prod-service"
  value = module.projects["non-prod-service"].project_id
}

output "gi_japan_sonpo_non_prod_project_id" {
  # Reference the project using the key "gi-japan-sonpo-non-prod-service"
  # (Using the full key from your tfvars/variable definition)
  value = module.projects["gi-japan-sonpo-non-prod-service"].project_id
}

output "gi_japan_ah_non_prod_project_id" {
  # Reference the project using the key "gi-japan-ah-non-prod-service"
  value = module.projects["gi-japan-ah-non-prod-service"].project_id
}

output "logging_bucket_project_id" {
  # Reference the project using the key "logging-bucket-prj"
  value = module.projects["logging-bucket-prj"].project_id
}