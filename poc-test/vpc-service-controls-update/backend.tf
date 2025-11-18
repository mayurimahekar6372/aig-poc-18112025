terraform {
  backend "gcs" {
    bucket = "terraform-bucket-473206" # Change this!
    prefix = "state/vpc-service-controls-update"
  }
}