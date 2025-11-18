terraform {
  backend "gcs" {
    bucket = "terraform-bucket-473206" # Change this!
    prefix = "state/application-lynx/net-lb-app-int"
  }
}