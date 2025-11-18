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