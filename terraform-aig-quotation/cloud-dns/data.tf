# Read the project outputs to get the Service Project ID
data "terraform_remote_state" "projects" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/projects"
  }
}

# Read the networking outputs to get the VPC and Subnet links
data "terraform_remote_state" "networking" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/networking"
  }
}

data "terraform_remote_state" "private-service-connect" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/private-service-connect"
  }
}

data "terraform_remote_state" "static-ip-address" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/static-ip-address"
  }
}

data "terraform_remote_state" "application-lynx" {
  backend = "gcs"
  config = {
    bucket = "terraform-bucket-473206"
    prefix = "state/application-lynx/net-lb-app-int"
  }
}