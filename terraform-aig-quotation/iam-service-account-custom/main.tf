module "hub_iam_service_account" {
  source           = "../modules/service-account-iam-custom"
  project_id       = data.terraform_remote_state.projects.outputs.hub_network_project_id
  service_accounts = var.service_account_name
  custom_roles     = var.service_account_custom_roles
  sa_role_bindings = var.service_account_role_bindings
}
