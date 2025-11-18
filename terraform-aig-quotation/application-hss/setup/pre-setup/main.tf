terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 7.0.1, < 8.0.0"
    }
  }
}

resource "google_project_service" "enabled_apis" {
  project = var.project_id

  for_each = toset([
    "artifactregistry.googleapis.com",
    "compute.googleapis.com",
    "firestore.googleapis.com",
    "secretmanager.googleapis.com",
    "run.googleapis.com",
    "storage.googleapis.com",
    "workflows.googleapis.com",
    "cloudbuild.googleapis.com",
    "eventarc.googleapis.com",
    "eventarcpublishing.googleapis.com",
    "iam.googleapis.com",
    "vpcaccess.googleapis.com",
    "documentai.googleapis.com",
    "speech.googleapis.com",
  ])

  service = each.value
}

# Cloud Run UI Quotation

resource "google_service_account" "cloud_run_ui_quotation" {
  project      = var.project_id
  account_id   = "cloud-run-sa-ui-quotation"
  display_name = "Cloud Run UI Quotation Service Account"
}

resource "google_project_iam_member" "cloud_run_ui_quotation_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.cloud_run_ui_quotation.email}"
}

resource "google_project_iam_member" "cloud_run_ui_quotation_storage_object_user" {
  project = var.project_id
  role    = "roles/storage.objectUser"
  member  = "serviceAccount:${google_service_account.cloud_run_ui_quotation.email}"
}

resource "google_project_iam_member" "cloud_run_ui_quotation_cloud_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloud_run_ui_quotation.email}"
}

# Cloud Run Valiclass

resource "google_service_account" "cloud_run_valiclass" {
  project      = var.project_id
  account_id   = "cloud-run-sa-valiclass"
  display_name = "Cloud Run Validation Classification Service Account"
}

resource "google_project_iam_member" "cloud_run_valiclass_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.cloud_run_valiclass.email}"
}

resource "google_project_iam_member" "cloud_run_valiclass_storage_object_user" {
  project = var.project_id
  role    = "roles/storage.objectUser"
  member  = "serviceAccount:${google_service_account.cloud_run_valiclass.email}"
}

resource "google_project_iam_member" "cloud_run_valiclass_vertex_ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.cloud_run_valiclass.email}"
}

resource "google_project_iam_member" "cloud_run_valiclass_cloud_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloud_run_valiclass.email}"
}

# Cloud Run Extraction

resource "google_service_account" "cloud_run_extraction" {
  project      = var.project_id
  account_id   = "cloud-run-sa-extraction"
  display_name = "Cloud Run Extraction Service Account"
}

resource "google_project_iam_member" "cloud_run_extraction_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.cloud_run_extraction.email}"
}

resource "google_project_iam_member" "cloud_run_extraction_storage_object_user" {
  project = var.project_id
  role    = "roles/storage.objectUser"
  member  = "serviceAccount:${google_service_account.cloud_run_extraction.email}"
}

resource "google_project_iam_member" "cloud_run_extraction_doc_ai_api_user" {
  project = var.project_id
  role    = "roles/documentai.apiUser"
  member  = "serviceAccount:${google_service_account.cloud_run_extraction.email}"
}

resource "google_project_iam_member" "cloud_run_extraction_cloud_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloud_run_extraction.email}"
}

# Cloud Run Quotation

resource "google_service_account" "cloud_run_quotation" {
  project      = var.project_id
  account_id   = "cloud-run-sa-quotation"
  display_name = "Cloud Run Quotation Service Account"
}

resource "google_project_iam_member" "cloud_run_quotation_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.cloud_run_quotation.email}"
}

resource "google_project_iam_member" "cloud_run_quotation_vertex_ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.cloud_run_quotation.email}"
}

resource "google_project_iam_member" "cloud_run_quotation_secret_accessor" {
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.cloud_run_quotation.email}"
}

resource "google_project_iam_member" "cloud_run_quotation_cloud_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloud_run_quotation.email}"
}

# Cloud Run Document Store

resource "google_service_account" "cloud_run_document_store" {
  project      = var.project_id
  account_id   = "cloud-run-sa-document-store"
  display_name = "Cloud Run Document Store Service Account"
}

resource "google_project_iam_member" "cloud_run_document_store_datastore_user" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.cloud_run_document_store.email}"
}

resource "google_project_iam_member" "cloud_run_document_store_service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.cloud_run_document_store.email}"
}

resource "google_project_iam_member" "cloud_run_document_store_cloud_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloud_run_document_store.email}"
}

# Cloud Run UI Transcription

resource "google_service_account" "cloud_run_ui_transcription" {
  project      = var.project_id
  account_id   = "cloud-run-sa-ui-transcription"
  display_name = "Cloud Run UI Transcription Service Account"
}

resource "google_project_iam_member" "cloud_run_ui_transcription_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.cloud_run_ui_transcription.email}"
}

resource "google_project_iam_member" "cloud_run_ui_transcription_cloud_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloud_run_ui_transcription.email}"
}

# Cloud Run Transcription

resource "google_service_account" "cloud_run_transcription" {
  project      = var.project_id
  account_id   = "cloud-run-sa-transcription"
  display_name = "Cloud Run Transcription Service Account"
}

resource "google_project_iam_member" "cloud_run_transcription_datastore_user" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.cloud_run_transcription.email}"
}

resource "google_project_iam_member" "cloud_run_transcription_storage_object_user" {
  project = var.project_id
  role    = "roles/storage.objectUser"
  member  = "serviceAccount:${google_service_account.cloud_run_transcription.email}"
}

resource "google_project_iam_member" "cloud_run_transcription_eventarc_event_receiver" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.cloud_run_transcription.email}"
}

resource "google_project_iam_member" "cloud_run_transcription_speech_client" {
  project = var.project_id
  role    = "roles/speech.client"
  member  = "serviceAccount:${google_service_account.cloud_run_transcription.email}"
}

resource "google_project_iam_member" "cloud_run_transcription_cloud_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloud_run_transcription.email}"
}

# Cloud Run Summarization

resource "google_service_account" "cloud_run_summarization" {
  project      = var.project_id
  account_id   = "cloud-run-sa-summarization"
  display_name = "Cloud Run Summarization Service Account"
}

resource "google_project_iam_member" "cloud_run_summarization_datastore_user" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.cloud_run_summarization.email}"
}

resource "google_project_iam_member" "cloud_run_summarization_storage_object_user" {
  project = var.project_id
  role    = "roles/storage.objectUser"
  member  = "serviceAccount:${google_service_account.cloud_run_summarization.email}"
}

resource "google_project_iam_member" "cloud_run_summarization_vertex_ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_service_account.cloud_run_summarization.email}"
}

resource "google_project_iam_member" "cloud_run_summarization_cloud_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloud_run_summarization.email}"
}

# Cloud Run Transcription Store

resource "google_service_account" "cloud_run_transcription_store" {
  project      = var.project_id
  account_id   = "cloud-run-sa-transcript-store"
  display_name = "Cloud Run Transcription Store Service Account"
}

resource "google_project_iam_member" "cloud_run_transcription_store_datastore_user" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.cloud_run_transcription_store.email}"
}

resource "google_project_iam_member" "cloud_run_transcription_store_cloud_trace_agent" {
  project = var.project_id
  role    = "roles/cloudtrace.agent"
  member  = "serviceAccount:${google_service_account.cloud_run_transcription_store.email}"
}

# Cloud Storage Signer

resource "google_service_account" "storage_signer" {
  project      = var.project_id
  account_id   = "storage-signer-sa"
  display_name = "Cloud Storage Signer Service Account"
}

resource "google_project_iam_member" "storage_signer_storage_object_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.storage_signer.email}"
}

resource "google_project_iam_member" "storage_signer_service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.storage_signer.email}"
}

# Eventarc

resource "google_service_account" "eventarc" {
  project      = var.project_id
  account_id   = "eventarc-sa"
  display_name = "Eventarc Service Account"
}

resource "google_project_iam_member" "eventarc_event_receiver" {
  project = var.project_id
  role    = "roles/eventarc.eventReceiver"
  member  = "serviceAccount:${google_service_account.eventarc.email}"
}

resource "google_project_iam_member" "eventarc_workflow_invoker" {
  project = var.project_id
  role    = "roles/workflows.invoker"
  member  = "serviceAccount:${google_service_account.eventarc.email}"
}

# Workflows

resource "google_service_account" "workflow" {
  project      = var.project_id
  account_id   = "workflow-sa"
  display_name = "Workflow Service Account"
}

resource "google_project_iam_member" "workflow_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.workflow.email}"
}

# Compute Default

data "google_compute_default_service_account" "compute" {
  project = var.project_id
}

resource "google_project_iam_member" "compute_artifact_registry_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${data.google_compute_default_service_account.compute.email}"
}

resource "google_project_iam_member" "compute_artifact_registry_writer" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${data.google_compute_default_service_account.compute.email}"
}

resource "google_project_iam_member" "compute_run_developer" {
  project = var.project_id
  role    = "roles/run.developer"
  member  = "serviceAccount:${data.google_compute_default_service_account.compute.email}"
}

resource "google_project_iam_member" "compute_run_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${data.google_compute_default_service_account.compute.email}"
}

resource "google_project_iam_member" "compute_logs_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${data.google_compute_default_service_account.compute.email}"
}

resource "google_project_iam_member" "compute_service_account_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${data.google_compute_default_service_account.compute.email}"
}

resource "google_project_iam_member" "compute_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${data.google_compute_default_service_account.compute.email}"
}

resource "google_project_iam_member" "compute_storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${data.google_compute_default_service_account.compute.email}"
}

resource "google_project_iam_member" "compute_workflows_editor" {
  project = var.project_id
  role    = "roles/workflows.editor"
  member  = "serviceAccount:${data.google_compute_default_service_account.compute.email}"
}