terraform {
  backend "gcs" {
    bucket = "terraform-bucket-473206" # Use the same bucket name!
    prefix = "state/firewall"
  }
}