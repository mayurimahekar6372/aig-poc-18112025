billing_account = "018D06-CEDD3B-494B8E"

project_details = {
  "hub-network" = {
    name   = "1425566"
    prefix = "hub-network"
    labels = {
      bu-environment-type = "non-prod",
    }
    services = [
      "compute.googleapis.com",
      "dns.googleapis.com",
      "storage-api.googleapis.com"
    ]
  },
  "non-prod-host" = {
    name   = "1425588"
    prefix = "non-prod-host"
    labels = {
      bu-environment-type = "non-prod",
    }
    services = [
      "compute.googleapis.com",
      "containerthreatdetection.googleapis.com",
      "dlp.googleapis.com",
      "dns.googleapis.com",
      "networkconnectivity.googleapis.com",
      "networkmanagement.googleapis.com",
      "osconfig.googleapis.com",
      "oslogin.googleapis.com",
      "servicedirectory.googleapis.com",
      "websecurityscanner.googleapis.com",
      "iam.googleapis.com"
    ]
  },
  "non-prod-service" = {
    name   = "67326746"
    prefix = "non-prod-service"
    labels = {
      bu-environment-type = "non-prod"
      bu-application-name = "google-cloud-platform"
    }
  }
  "gi-japan-sonpo-non-prod-service" = {
    name   = "67326746"
    prefix = "sonpo-non-prod"
    labels = {
      bu-environment-type = "non-prod"
      bu-application-name = "google-cloud-platform"
    }
  }
  "gi-japan-sonpo-non-prod-service" = {
    name   = "67326746"
    prefix = "sonpo-non-prod"
    labels = {
      bu-environment-type = "non-prod"
      bu-application-name = "google-cloud-platform"
    }
  }
  "gi-japan-ah-non-prod-service" = {
    name   = "67326746"
    prefix = "ah-non-prod"
    labels = {
      bu-environment-type = "non-prod"
      bu-application-name = "google-cloud-platform"
    }
  }
  "logging-bucket-prj" = {
    name   = "67326746"
    prefix = "logging-bucket"
    labels = {
      bu-environment-type = "non-prod"
      bu-application-name = "google-cloud-platform"
    }
    services = []
  }
}