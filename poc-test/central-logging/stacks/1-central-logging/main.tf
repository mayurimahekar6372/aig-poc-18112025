terraform {
  backend "gcs" {
    bucket = "your-terraform-state-bucket" # <-- UPDATE THIS
    prefix = "stacks/central-logging"
  }
}

provider "google" {
  project = var.project_id
}

# Call the local module to create the bucket
module "logging_bucket" {
  source = "../../modules/gcp-logging-bucket"

  # Pass variables to the module
  project_id     = var.project_id
  bucket_name    = var.bucket_name
  retention_days = var.retention_days
}