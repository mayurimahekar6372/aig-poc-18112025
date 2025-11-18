vm_instances = {
  # VM 1: The existing instance in the service project
  "service-project-vm" = {
    name           = "test-vm-01"
    region         = "us-central1"
    machine_type   = "e2-medium"
    target_network = "shared-service"
    labels = {
      bu-environment-type = "non-prod",
      bu-application-name = "google-cloud-platform"
    }
  },
  # VM 2: The new instance in the hub project
  "hub-project-vm" = {
    name           = "hub-vm-01"
    region         = "us-central1"
    machine_type   = "e2-small"
    target_network = "hub-network"
    labels = {
      bu-environment-type = "non-prod",
      bu-application-name = "google-cloud-platform"
    }
  }
}