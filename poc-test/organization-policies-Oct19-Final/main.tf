module "org_policies" {
  source          = "../modules/organization"
  organization_id = var.organization_id
  org_policies    = var.org_policies
}

module "folder_policies" {
  source        = "../modules/folder"
  org_policies  = var.folder_org_policies
  id            = data.terraform_remote_state.folders.outputs.hub_network_folder_id
  folder_create = false
}