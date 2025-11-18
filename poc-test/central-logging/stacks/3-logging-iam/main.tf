terraform {
  backend "gcs" {
    bucket = "your-terraform-state-bucket" # <-- UPDATE THIS
    prefix = "stacks/logging-iam"
  }
}

# Get outputs from Stack 1 (the bucket)
data "terraform_remote_state" "logging" {
  backend = "gcs"
  config = {
    bucket = "your-terraform-state-bucket" # <-- UPDATE THIS
    prefix = "stacks/central-logging"
  }
}

# Get output from Stack 2 (the sink)
data "terraform_remote_state" "organization" {
  backend = "gcs"
  config = {
    bucket = "your-terraform-state-bucket" # <-- UPDATE THIS
    prefix = "stacks/organization"
  }
}

# Configure the provider to act on the *logging project*
provider "google" {
  project = data.terraform_remote_state.logging.outputs.bucket_project_id
}

# The "glue" resource
resource "google_logging_project_bucket_iam_member" "sink_writer" {
  project = data.terraform_remote_state.logging.outputs.bucket_project_id
  bucket  = data.terraform_remote_state.logging.outputs.bucket_name
  role    = "roles/logging.bucketWriter"
  member  = data.terraform_remote_state.organization.outputs.sink_writer_identity
}