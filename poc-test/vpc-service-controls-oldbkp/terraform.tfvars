organization_id = "organizations/1024767897869"

additional_projects = [
  "esoteric-source-472616-f3",
#   "terraform-473206"
]

additional_vpcs = [
#   "terraform-vpc",
#   "vpn-testing"
]

access_levels = {
  a1 = {
    combining_function = "AND"
    conditions = [
      { ip_subnetworks = ["101.101.101.0/24"] }
    ]
  },
  a2 = {
    combining_function = "AND"
    conditions = [
      { ip_subnetworks = ["101.101.102.0/24"] }
    ]
  },
  a3 = {
    combining_function = "AND"
    conditions = [
      { ip_subnetworks = ["101.103.102.0/24"] }
    ]
  },
}

ingress_policies = {
  "allow-tf-state-access" = {
    title = "Allow external access for Terraform state management"
    from = {
      identities = [ "user:mayuri@ziyap.altostrat.com" ]
    }
    to = {
      resources = ["*"] 
      operations = [
        {
          service_name = "storage.googleapis.com"
          method_selectors = ["*"] 
        }
      ]
    }
  }
}
perimeter_config = {
  prod_r1 = {
    title                     = "vpcsc-perimeter-prod"
    use_explicit_dry_run_spec = true
    access_level_keys         = ["a1", "a3"]
    spec = {
      restricted_services = ["storage.googleapis.com", "bigquery.googleapis.com"]
      ingress_policies    = []
      egress_policies     = []
      vpc_accessible_services = {
        allowed_services   = ["storage.googleapis.com"]
        enable_restriction = true
      }
    }
    status = {
      restricted_services = ["storage.googleapis.com"]
      ingress_policies    = []
      egress_policies     = []
      vpc_accessible_services = {
        allowed_services   = ["storage.googleapis.com"]
        enable_restriction = true
      }
    }
  }

  #   poc_r1 = {
  #     title                       = "vpcsc-perimeter-poc"
  #     use_explicit_dry_run_spec   = true
  #     access_level_keys           = ["a2"] 
  #     spec = {
  #       restricted_services       = ["cloudfunctions.googleapis.com"] # Different services
  #       ingress_policies          = []
  #       egress_policies           = []
  #       vpc_accessible_services = {
  #         allowed_services   = ["cloudfunctions.googleapis.com"]
  #         enable_restriction = true
  #       }
  #     }
  #   }
}