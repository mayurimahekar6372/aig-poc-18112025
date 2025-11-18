output "gcs_quotation_bucket_name" {
  description = "Cloud Storage Quotation Bucket Name."
  value       = module.gcs_quotation.name
}

output "gcs_transcription_bucket_name" {
  description = "Cloud Storage Transcription Bucket Name."
  value       = module.gcs_transcription.name
}