data "google_compute_network" "vpc_network" {
  project = var.infra_project_id 
  name    = var.vpc_network_name
}

data "google_compute_subnetwork" "app_subnet" {
  project = var.infra_project_id 
  name    = var.app_subnet_name
  region  = var.region
}

data "google_compute_subnetwork" "psc_subnet" {
  project = var.infra_project_id 
  name    = var.psc_subnet_name
  region  = var.region
}

module "ilb_quotation" {
  source = "../../modules/net-lb-app-int"

  name       = var.ilb_quotation_name
  project_id = var.project_id
  region     = var.region
  backend_service_configs = {
    default = {
      backends      = [{ group = "neg-quotation" }]
      health_checks = []
      port_name     = "http"
    }
  }
  health_check_configs = {}
  neg_configs = {
    neg-quotation = {
      cloudrun = {
        region = var.region
        target_service = {
          name = "cloud-run-ui-quotation"
        }
      }
    }
  }
  vpc_config = {
    network    = data.google_compute_network.vpc_network.self_link
    subnetwork = data.google_compute_subnetwork.app_subnet.self_link
  }
  service_attachment = {
    nat_subnets          = [data.google_compute_subnetwork.psc_subnet.self_link]
    automatic_connection = false
    consumer_accept_lists = {
      (var.project_id) = 10
    }
  }
}

module "ilb_transcription" {
  source = "../../modules/net-lb-app-int"

  name       = var.ilb_transcription_name
  project_id = var.project_id
  region     = var.region
  backend_service_configs = {
    default = {
      backends      = [{ group = "neg-transcription" }]
      health_checks = []
      port_name     = "http"
    }
  }
  health_check_configs = {}
  neg_configs = {
    neg-transcription = {
      cloudrun = {
        region = var.region
        target_service = {
          name = "cloud-run-ui-transcription"
        }
      }
    }
  }
  vpc_config = {
    network    = data.google_compute_network.vpc_network.self_link
    subnetwork = data.google_compute_subnetwork.app_subnet.self_link
  }
  service_attachment = {
    nat_subnets          = [data.google_compute_subnetwork.psc_subnet.self_link]
    automatic_connection = false
    consumer_accept_lists = {
      (var.project_id) = 10
    }
  }
}