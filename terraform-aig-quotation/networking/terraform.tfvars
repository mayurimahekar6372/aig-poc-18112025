non_prod_vpc_subnets = [
  {
    ip_cidr_range = "10.0.0.0/24"
    name          = "nonprod-app-us-subnet"
    region        = "us-central1"
    secondary_ip_ranges = {
      pods     = { ip_cidr_range = "172.16.0.0/21" }
      services = { ip_cidr_range = "192.168.0.0/24" }
    }
  }
]

hub_vpc_subnets = [
  {
    ip_cidr_range = "10.10.0.0/24"
    name          = "hub-vpc-subnet-1"
    region        = "us-central1"
  }
]

subnets_proxy_only = [{
  ip_cidr_range = "10.10.2.0/24"
  name          = "regional-managed-proxy-subnet"
  region        = "us-central1"
  active        = true
  global        = false
}]

subnets_psc = [{
  ip_cidr_range = "10.10.3.0/24"
  name          = "psc-subnet"
  region        = "us-central1"
}]