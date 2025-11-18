organization_id = "organizations/1024767897869"

access_policy_title = "access-policy"

exclude_prod_projects = [
  "hub-network-1425566",
  "hub-network-1425534",
  "terraform-473206",
]

exclude_prod_vpcs = [
  "hub-vpc-network",
  "terraform-vpc",
  "vpn-testing"
]

exclude_nprod_projects = [
  "esoteric-source-472616-f3",
  "non-prod-host-1425588",
  "non-prod-service-67326746",
  "hub-network-1425534",
  "non-prod-host-1425509",
  "non-prod-service-152526357",
  "poc-service-475809",
  "sonpo-non-prod-67326746",
  "ah-non-prod-67326746"
]

exclude_nprod_vpcs = [
  "non-prod-host-vpc",
  "poc-test-vpc",
  "poc-vpc"
]

vpc_sc_configs = {
  "prod_config" = {
    access_levels = {
      pa1 = {
        combining_function = "AND"
        conditions = [
          { ip_subnetworks = ["157.45.61.254/32"] }
        ]
      }
      pa2 = {
        combining_function = "AND"
        conditions = [
          { ip_subnetworks = [
            "157.45.61.110/32",
            "157.45.61.111/32"
          ] }
        ]
      }
    }
    egress_policies  = {}
    ingress_policies = {}
    perimeters = {
      prod = {
        title                     = "prod-perimeter"
        use_explicit_dry_run_spec = true
        spec = {
          access_levels    = ["pa1", "pa2"]
          ingress_policies = []
          egress_policies  = []
        }
        status = {}
      }
    }
  }
  "non_prod_config" = {
    access_levels = {
      na1 = {
        combining_function = "AND"
        conditions = [
          { ip_subnetworks = ["157.45.161.196"] }
        ]
      }
    }
    egress_policies  = {}
    ingress_policies = {}
    perimeters = {
      nprod = {
        title                     = "non-prod-perimeter"
        use_explicit_dry_run_spec = true
        spec                      = {
          access_levels    = ["na1"]
          ingress_policies = []
          egress_policies  = []}
        status = {}
      }
    }
  }
}

