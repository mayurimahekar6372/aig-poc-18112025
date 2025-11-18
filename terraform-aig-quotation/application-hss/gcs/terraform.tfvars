project_id = "non-prod-service-67326746"
region = "asia-northeast1"
bucket_name_prefix = "non-prod-service-67326746"
bucket_quotation_name = "gcs-quotation"
bucket_transcription_name = "gcs-transcription"
cors_quotation = {
  origin = [
    "*" # '*' allows all origins
  ]
  method = [
    "PUT",
  ]
  response_header = [
    "Content-Type",
  ]
  max_age_seconds = 3600
}
cors_transcription = {
  origin = [
    "*" # '*' allows all origins
  ]
  method = [
    "PUT",
  ]
  response_header = [
    "Content-Type",
  ]
  max_age_seconds = 3600
}