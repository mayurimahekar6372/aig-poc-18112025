project_id         = "non-prod-service-67326746"
infra_project_id   = "non-prod-host-1425588"
region             = "us-central1" #"asia-northeast1"
vpc_network_name   = "non-prod-host-vpc"
app_subnet_name    = "nonprod-app-us-subnet"
psc_subnet_name    = "psc-subnet"
ilb_quotation_name = "ilb-quotation"


cert_name = "poc"
labels = {
  bu-environment-type = "non-prod"
  bu-application-name = "google-cloud-platform"
}
lynx_ip_address = "10.0.0.14"