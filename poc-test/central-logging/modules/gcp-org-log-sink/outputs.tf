output "writer_identity" {
  description = "The service account that must be given write permission on the bucket."
  value       = google_organization_log_sink.org_sink.writer_identity
}