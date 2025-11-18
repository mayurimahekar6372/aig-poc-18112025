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

# module "ilb_quotation_http" {
#   source = "../../modules/net-lb-app-int"

#   name       = var.ilb_quotation_name
#   project_id = var.project_id
#   region     = var.region

#   backend_service_configs = {
#     default = {
#       backends      = [{ group = "neg-quotation" }]
#       health_checks = []
#       port_name     = "http"
#     }
#   }
#   health_check_configs = {}
#   neg_configs = {
#     neg-quotation = {
#       cloudrun = {
#         region = var.region
#         target_service = {
#           name = "helloworld"
#         }
#       }
#     }
#   }
#   vpc_config = {
#     network    = data.google_compute_network.vpc_network.self_link
#     subnetwork = data.google_compute_subnetwork.app_subnet.self_link
#   }
#   service_attachment = {
#     nat_subnets          = [data.google_compute_subnetwork.psc_subnet.self_link]
#     automatic_connection = false
#     consumer_accept_lists = {
#       (var.project_id) = 10
#     }
#   }
# }


module "ilb_quotation_http" {
  source = "../../modules/net-lb-app-int"

  name       = "${var.ilb_quotation_name}-http"
  project_id = var.project_id
  region     = var.region

  # backend_service_configs = {
  #   default = {
  #     backends      = [{ group = "neg-quotation" }]
  #     health_checks = []
  #     port_name     = "http"
  #   }
  # }
  # health_check_configs = {}
  # neg_configs = {
  #   neg-quotation = {
  #     cloudrun = {
  #       region = var.region
  #       target_service = {
  #         name = "helloworld"
  #       }
  #     }
  #   }
  # }
  vpc_config = {
    network    = data.google_compute_network.vpc_network.self_link
    subnetwork = data.google_compute_subnetwork.app_subnet.self_link
  }
  # service_attachment = {
  #   nat_subnets          = [data.google_compute_subnetwork.psc_subnet.self_link]
  #   automatic_connection = false
  #   consumer_accept_lists = {
  #     (var.project_id) = 10
  #   }
  # }
}

data "google_certificate_manager_certificates" "default" {
  region = var.region
}

module "ip_address" {
  source     = "../../modules/net-address"
  project_id = var.project_id
  internal_addresses = {
    lynx-ip = {
      address    = var.lynx_ip_address
      region     = var.region
      subnetwork = data.google_compute_subnetwork.app_subnet.self_link
    }
  }
}

module "ilb_quotation_https" {
  source = "../../modules/net-lb-app-int"

  name       = var.ilb_quotation_name
  project_id = var.project_id
  region     = var.region

  backend_service_configs = {
    default = {
      backends      = [{ group = "neg-quotation" }]
      health_checks = []
      protocol      = "HTTPS"
    }
  }

  protocol = "HTTPS"
  address  = module.ip_address.internal_addresses.lynx-ip.address
  https_proxy_config = {
    certificate_manager_certificates = [for cert in data.google_certificate_manager_certificates.default.certificates : cert.name]
  }

  health_check_configs = {}
  neg_configs = {
    neg-quotation = {
      cloudrun = {
        region = var.region
        target_service = {
          name = "helloworld"
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
  labels = var.labels
}