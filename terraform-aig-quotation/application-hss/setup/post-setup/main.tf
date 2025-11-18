# Cloud Run UI Quotation

resource "google_cloud_run_v2_service_iam_member" "allusers_run_invoker_on_cloud_run_ui_quotation" {
  project  = var.project_id
  location = var.region
  name     = "cloud-run-ui-quotation"
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Cloud Run UI Transcription

resource "google_cloud_run_v2_service_iam_member" "allusers_run_invoker_on_cloud_run_ui_transcription" {
  project  = var.project_id
  location = var.region
  name     = "cloud-run-ui-transcription"
  role     = "roles/run.invoker"
  member   = "allUsers"
}