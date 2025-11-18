# Read the project outputs to get the Service Project ID
data "terraform_remote_state" "projects" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/projects"
  }
}

# Read the networking outputs to get the VPC and Subnet links
data "terraform_remote_state" "networking" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/networking"
  }
}

data "external" "vpc_sc_services_json" {
  program = ["bash", "-c", <<-EOT
    # List supported services in JSON format.
    # Use jq to collect all names and convert the resulting array to a single JSON string.
    gcloud access-context-manager supported-services list --format=json --limit=9999 | \
      jq -c '{services: (map(.name) | @json)}'
  EOT
  ]
}

data "google_access_context_manager_access_policy" "policy-org" {
  parent = var.organization_id
}

data "google_project" "prod_projects" {
  for_each   = toset(local.prod_projects_list)
  project_id = each.key
}

data "google_project" "non_prod_projects" {
  for_each   = toset(local.non_prod_projects_list)
  project_id = each.key
}

data "google_project" "additional_projects" {
  for_each   = toset(keys(var.additional_projects_vpcs))
  project_id = each.key
}

data "google_compute_network" "additional_vpcs" {
  for_each = local.project_vpc_map
  project  = each.value.project
  name     = each.value.name
}