organization_id = "organizations/1024767897869"

access_policy_title = "org-access-policy"

excluded_projects = [
  "hub-network-1425534",
  "non-prod-host-1425509",
  "non-prod-service-152526357",
  "terraform-473206"
]

excluded_vpcs = [
  "terraform-vpc",
  "vpn-testing"
]

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
    egress_policies  = {}
    ingress_policies = {}
    perimeters = {
      prod_r1 = {
        title                     = "vpcsc-perimeter-prod"
        use_explicit_dry_run_spec = true
        spec = {
          access_levels    = ["a1"]
          ingress_policies = []
          egress_policies  = []
        }
        status = {}
      }
    }
  }
}