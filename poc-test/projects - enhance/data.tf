data "terraform_remote_state" "folders" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206" # Change this!
    prefix = "state/folders"
  }
}


# data "google_project" "additional_projects" {
#   for_each   = var.additional_projects
#   project_id = each.value.project_id
# }