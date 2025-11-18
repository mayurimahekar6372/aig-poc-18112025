module "non_prod_folder" {
  source = "../modules/folder"
  name   = "non-prod"
  parent = var.parent_folder
}

module "hub_network_folder" {
  source = "../modules/folder"
  name   = "hub-network-folder"
  parent = var.parent_folder
}

module "non_prod_host_folder" {
  source = "../modules/folder"
  name   = "non-prod-host-folder"
  parent = module.non_prod_folder.id
}

module "non_prod_service_folder" {
  source = "../modules/folder"
  name   = "non-prod-service-folder"
  parent = module.non_prod_folder.id
}

#GI Folder
module "gi_folder" {
  source = "../modules/folder"
  name   = "GI"
  parent = var.parent_folder
}

module "gi_japan_folder" {
  source = "../modules/folder"
  name   = "JAPAN"
  parent = module.gi_folder.id
}

module "gi_japan_non_prod_folder" {
  source = "../modules/folder"
  name   = "Non-Prod"
  parent = module.gi_japan_folder.id
}



# module "iso_folder" {
#   source = "../modules/folder"
#   name   = "ISO"
#   parent = "organizations/1024767897869"
# }