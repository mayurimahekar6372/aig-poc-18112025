module "gcs_quotation" {
  source = "../../modules/gcs"

  name       = var.bucket_quotation_name
  project_id = var.project_id
  location   = var.region
  prefix     = var.bucket_name_prefix
  cors       = var.cors_quotation
}

module "gcs_transcription" {
  source = "../../modules/gcs"

  name       = var.bucket_transcription_name
  project_id = var.project_id
  location   = var.region
  prefix     = var.bucket_name_prefix
  cors       = var.cors_transcription
}