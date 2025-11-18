module "project_apis" {
  source = "../modules/api-enablement"

  for_each = var.projects_config

  project_id = data.terraform_remote_state.projects.outputs[each.key]
  services   = each.value
  disable_on_destroy = true
  disable_dependent_services = true
}