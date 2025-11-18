data "terraform_remote_state" "networking" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206" # Change this!
    prefix = "state/networking"
  }
}


data "terraform_remote_state" "projects" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/projects"
  }
}