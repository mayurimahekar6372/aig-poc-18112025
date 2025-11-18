terraform {
  backend "gcs" {
    bucket = "your-terraform-state-bucket" # <-- UPDATE THIS
    prefix = "stacks/my-app-project"
  }
}

provider "google" {
  project = var.project_id
}

# Using the official CFF network module
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.1"

  project_id   = var.project_id
  network_name = "my-app-vpc"
  
  subnets = [
    {
      subnet_name   = "my-app-subnet-us-central1"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-central1"

      # This is the key: enabling log generation
      subnet_flow_logs = var.enable_flow_logs
      log_config = {
        aggregation_interval = "INTERVAL_30_SEC"
        flow_sampling        = 0.5 # 50%
        metadata             = "INCLUDE_ALL_METADATA"
      }
    }
  ]
}