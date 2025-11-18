output "cloud_run_ui_quotation_service_account_email" {
  description = "Cloud Run UI quotation service account email."
  value       = google_service_account.cloud_run_ui_quotation.email
}

output "cloud_run_document_store_service_account_email" {
  description = "Cloud Run Document Store service account email."
  value       = google_service_account.cloud_run_document_store.email
}

output "cloud_run_valiclass_service_account_email" {
  description = "Cloud Run Validation Classification service account email."
  value       = google_service_account.cloud_run_valiclass.email
}

output "cloud_run_extraction_service_account_email" {
  description = "Cloud Run Extraction service account email."
  value       = google_service_account.cloud_run_extraction.email
}

output "cloud_run_quotation_service_account_email" {
  description = "Cloud Run Quotation service account email."
  value       = google_service_account.cloud_run_quotation.email
}

output "cloud_run_ui_transcription_service_account_email" {
  description = "Cloud Run UI transcription service account email."
  value       = google_service_account.cloud_run_ui_transcription.email
}

output "cloud_run_transcription_store_service_account_email" {
  description = "Cloud Run Transcription Store service account email."
  value       = google_service_account.cloud_run_transcription_store.email
}

output "cloud_run_transcription_service_account_email" {
  description = "Cloud Run Transcription service account email."
  value       = google_service_account.cloud_run_transcription.email
}

output "cloud_run_summarization_service_account_email" {
  description = "Cloud Run Summarization service account email."
  value       = google_service_account.cloud_run_summarization.email
}

output "storage_signer_service_account_email" {
  description = "Cloud Storage Signer service acount email."
  value       = google_service_account.storage_signer.email
}

output "eventarc_service_account_email" {
  description = "Eventarc service acount."
  value       = google_service_account.eventarc.email
}

output "workflow_service_account_email" {
  description = "Workflow service acount."
  value       = google_service_account.workflow.email
}