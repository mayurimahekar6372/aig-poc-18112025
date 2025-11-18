# -----------------------------------------------------------------------------
# INPUT VARIABLES
# -----------------------------------------------------------------------------

variable "organization_id" {
  type        = string
  description = "The ID of the Google Cloud organization (e.g., '123456789012')."
}

variable "billing_project" {
  type        = string
  description = "A project ID to use for billing provider operations."
}

variable "custom_roles" {
  type        = map(list(string))
  description = "A map where keys are the custom role IDs and values are lists of predefined GCP roles to include."
  default = {
    "cloudcore_admin_role" = [
      "roles/resourcemanager.organizationAdmin",
      "roles/billing.admin",
      "roles/iam.organizationRoleAdmin",
    ]
    "cloudcore_cloud_engineer_role" = [
      "roles/compute.admin",
      "roles/storage.admin",
      "roles/container.admin",
      "roles/cloudsql.admin",
      "roles/pubsub.admin",
      "roles/logging.configWriter",
      "roles/iam.serviceAccountUser",
    ]
    "cloudcore_billing_administrator_role" = [
      "roles/billing.admin",
    ]
    "cloudcore_network_administrator_role" = [
      "roles/compute.networkAdmin",
      "roles/compute.securityAdmin",
      "roles/dns.admin",
      "roles/logging.viewer",
    ]
    "cloudcore_cloud_reader_role" = [
      "roles/viewer",
    ]
    "cloudcore_cloud_ops_1_role" = [
      "roles/monitoring.viewer",
      "roles/logging.viewer",
      "roles/compute.viewer",
      "roles/storage.objectViewer",
      "roles/errorreporting.viewer",
    ]
    "cloudcore_cloud_ops_2_role" = [
      # Includes all L1 permissions plus editor/operator roles
      "roles/monitoring.viewer",
      "roles/logging.viewer",
      "roles/storage.objectViewer",
      "roles/errorreporting.viewer",
      "roles/compute.instanceAdmin.v1",
      "roles/pubsub.editor",
      "roles/cloudsql.editor",
      "roles/container.developer",
    ]
  }
}