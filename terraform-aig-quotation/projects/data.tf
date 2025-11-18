data "terraform_remote_state" "folders" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206" # Change this!
    prefix = "state/folders"
  }
}