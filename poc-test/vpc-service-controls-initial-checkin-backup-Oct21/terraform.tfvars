organization_id = "organizations/1024767897869"

additional_projects_vpcs = {
  "esoteric-source-472616-f3" = ["poc-vpc", "poc-test-vpc"]
  "terraform-473206"          = []
}

vpc_sc_configs = {
  "prod_config" = {
    access_levels = {
      a1 = {
        combining_function = "AND"
        conditions = [
          { ip_subnetworks = ["157.45.61.254/32"] }
        ]
      }
    }
    egress_policies = {}
    ingress_policies = {
      "allow-tf-state-access" = {
        title = "Allow external access for Terraform state management"
        from = {
          identities    = ["user:mayuri@ziyap.altostrat.com"]
          access_levels = ["a1"]
        }
        to = {
          resources = ["*"]
          operations = [
            {
              service_name     = "storage.googleapis.com"
              method_selectors = ["*"]
            }
          ]
        }
      }
    }
    perimeters = {
      prod_r1 = {
        title                     = "vpcsc-perimeter-prod"
        use_explicit_dry_run_spec = true
        spec = {
          access_levels    = ["a1"]
          ingress_policies = ["allow-tf-state-access"]
          egress_policies  = []
        }
        status = {}
      }
    }
  }

  # "dev_config" = {
  #   access_levels = {
  #     dev_al = {
  #       combining_function = "OR"
  #       conditions = [
  #         { members = ["serviceAccount:930497980218-compute@developer.gserviceaccount.com"] }
  #       ]
  #     }
  #   }
  #   egress_policies = {
  #     allow_to_logging = {
  #       from = {
  #         identities = ["group:test-admin@ziyap.altostrat.com"]
  #       }
  #       to = {
  #         operations = [{
  #           method_selectors = ["*"]
  #           service_name     = "logging.googleapis.com"
  #         }]
  #         resources = ["*"]
  #       }
  #     }
  #   }
  #   ingress_policies = {}

  #   perimeters = {
  #     dev_r2 = {
  #       title                     = "vpcsc-perimeter-dev"
  #       use_explicit_dry_run_spec = false
  #       spec                      = {}
  #       status = {
  #         access_levels    = ["dev_al"]
  #         ingress_policies = []
  #         egress_policies  = ["allow_to_logging"]
  #       }
  #     }
  #   }
  # }
}