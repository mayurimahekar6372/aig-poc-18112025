data "terraform_remote_state" "projects" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/projects"
  }
}