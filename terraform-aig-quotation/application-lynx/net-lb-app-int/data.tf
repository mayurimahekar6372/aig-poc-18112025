data "terraform_remote_state" "cloud-dns" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/cloud-dns"
  }
}