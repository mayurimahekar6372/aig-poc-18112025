# This output is read by Stack 3
output "sink_writer_identity" {
  description = "The sink's service account email."
  value       = module.org_sink.writer_identity
}