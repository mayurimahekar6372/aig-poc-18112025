locals {
  # 1. Create a map to easily look up network details based on a simple key.
  network_details = {
    "shared-service" = {
      project_id = data.terraform_remote_state.projects.outputs.non_prod_service_project_id
      network    = data.terraform_remote_state.networking.outputs.non_prod_vpc_self_link
      subnet     = data.terraform_remote_state.networking.outputs.non_prod_subnet_self_link
    },
    "hub-network" = {
      project_id = data.terraform_remote_state.projects.outputs.hub_network_project_id
      network    = data.terraform_remote_state.networking.outputs.hub_vpc_self_link
      subnet     = data.terraform_remote_state.networking.outputs.hub_subnet_self_link
    }
  }
}

# 2. For each VM defined in the .tfvars file, call the compute-vm module.
module "vm" {
  for_each = var.vm_instances

  source = "../modules/compute-vm"

  project_id = local.network_details[each.value.target_network].project_id
  zone       = "${each.value.region}-b"
  name       = each.value.name

  network_interfaces = [{
    network    = local.network_details[each.value.target_network].network
    subnetwork = local.network_details[each.value.target_network].subnet
  }]

  shielded_config = {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
  labels = each.value.labels
}