# Read the project outputs
data "terraform_remote_state" "projects" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/projects"
  }
}

# Read the networking outputs
data "terraform_remote_state" "networking" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/networking"
  }
}