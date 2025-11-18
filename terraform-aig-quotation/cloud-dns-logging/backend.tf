terraform {
  backend "gcs" {
    bucket = "terraform-bucket-473206" # Change this!
    prefix = "state/cloud-dns-logging"
  }
}