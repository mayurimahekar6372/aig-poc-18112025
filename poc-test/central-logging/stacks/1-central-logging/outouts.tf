# These outputs are read by other stacks
output "bucket_destination_id" {
  description = "The full destination path for the sink."
  value       = module.logging_bucket.id
}

output "bucket_name" {
  description = "The name of the bucket (for IAM)."
  value       = module.logging_bucket.name
}

output "bucket_project_id" {
  description = "The project ID of the bucket (for IAM)."
  value       = module.logging_bucket.project_id
}