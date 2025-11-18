data "terraform_remote_state" "projects" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206" # Use the same bucket name!
    prefix = "state/projects"
  }
}