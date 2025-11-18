# This resource creates the dedicated log bucket
resource "google_logging_project_bucket_config" "log_bucket" {
  # This is the fix for your error:
  # The resource argument is "project", not "project_id"
  project = var.project_id

  location       = var.location
  bucket_id      = var.bucket_name
  retention_days = var.retention_days
}