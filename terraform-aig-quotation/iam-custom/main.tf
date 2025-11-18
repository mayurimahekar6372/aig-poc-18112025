module "org_custom_iam_role" {
  source               = "../modules/org-iam-custom"
  organization_id      = var.organization_id
  billing_project      = var.billing_project
  custom_roles         = var.org_custom_roles
  custom_role_bindings = var.org_role_bindings
  excluded_permissions = var.organization_excluded_permissions
}

module "hub_project_iam_custom_role" {
  source               = "../modules/project-iam-custom"
  project_id           = data.terraform_remote_state.projects.outputs.hub_network_project_id
  custom_roles         = var.hub_project_custom_roles
  excluded_permissions = var.hub_project_excluded_permissions
  custom_role_bindings = var.hub_project_role_bindings
}

module "non_prod_host_project_iam_custom_role" {
  source               = "../modules/project-iam-custom"
  project_id           = data.terraform_remote_state.projects.outputs.non_prod_host_project_id
  custom_roles         = var.non_prod_host_project_custom_roles
  excluded_permissions = var.non_prod_host_project_excluded_permissions
  custom_role_bindings = var.non_prod_host_project_role_bindings
}

