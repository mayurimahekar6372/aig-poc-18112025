locals {

  dynamic_org_iam_bindings = {
    for role_id, members in var.org_role_assignments_config :

    # Key Construction: Dynamically insert the role_id into the ARN prefix
    "${var.organization_id}/roles/${role_id}" => members
  }

  dynamic_project_iam_bindings = {
    for role_id, members in var.project_role_assignments_config :

    # Key Construction: Dynamically insert the role_id 
    "projects/${data.terraform_remote_state.projects.outputs.hub_network_project_id}/roles/${role_id}" => members
  }
}

module "org_custom_role_iam" {
  source          = "../modules/organization"
  organization_id = var.organization_id
  custom_roles    = var.org_custom_roles # Your role definitions

  # Pass the dynamically generated map here
  iam = local.dynamic_org_iam_bindings
}

module "project_iam" {
  source = "../modules/project"
  name   = data.terraform_remote_state.projects.outputs.hub_network_project_id
  project_reuse = {
    use_data_source = true
  }
  custom_roles = var.project_custom_roles

  # Pass the dynamically generated map here
  iam = local.dynamic_project_iam_bindings
}
