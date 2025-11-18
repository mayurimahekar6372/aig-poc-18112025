terraform {
  backend "gcs" {
    bucket = "your-terraform-state-bucket" # <-- UPDATE THIS
    prefix = "stacks/organization"
  }
}

provider "google" {}

# Get the bucket's ID from Stack 1's remote state
data "terraform_remote_state" "logging" {
  backend = "gcs"
  config = {
    bucket = "your-terraform-state-bucket" # <-- UPDATE THIS
    prefix = "stacks/central-logging"
  }
}

# Call the local module to create the org sink
module "org_sink" {
  source = "../../modules/gcp-org-log-sink"

  sink_name    = var.sink_name
  org_id       = var.org_id
  filter       = var.vpc_log_filter
  
  # Pass in the output from Stack 1
  destination_bucket_id = data.terraform_remote_state.logging.outputs.bucket_destination_id
}