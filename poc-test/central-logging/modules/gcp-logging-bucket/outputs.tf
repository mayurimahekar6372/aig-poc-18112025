output "id" {
  description = "The full ID of the log bucket (its destination path)."
  value       = google_logging_project_bucket_config.log_bucket.id
}

output "name" {
  description = "The name of the log bucket."
  value       = google_logging_project_bucket_config.log_bucket.name
}

output "project_id" {
  description = "The project ID where the bucket lives."
  value       = var.project_id
}