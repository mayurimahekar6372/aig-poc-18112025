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

data "google_cloud_asset_search_all_resources" "projects" {
  scope = var.organization_id
  asset_types = [
    "cloudresourcemanager.googleapis.com/Project"
  ]
}

data "google_cloud_asset_search_all_resources" "vpc_networks" {
  scope = var.organization_id
  asset_types = [
    "compute.googleapis.com/Network"
  ]
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