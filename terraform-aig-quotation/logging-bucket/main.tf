# module "hub-bucket-default" {
#   source      = "../modules/logging-bucket"
#   parent_type = "project"
#   parent      = data.terraform_remote_state.projects.outputs.hub_network_project_id
#   name        = var.log_bucket_name
#   retention   = var.retention_days
# }

# module "non-prod-bucket-default" {
#   source      = "../modules/logging-bucket"
#   parent_type = "project"
#   parent      = data.terraform_remote_state.projects.outputs.non_prod_host_project_id
#   name        = var.log_bucket_name
#   retention   = var.retention_days
# }

# module "non-prod-service-bucket-default" {
#   source      = "../modules/logging-bucket"
#   parent_type = "project"
#   parent      = data.terraform_remote_state.projects.outputs.non_prod_service_project_id
#   name        = var.log_bucket_name
#   retention   = var.retention_days
# }

# module "logging-bucket" {
#   source      = "../modules/logging-bucket"
#   parent_type = "project"
#   parent      = data.terraform_remote_state.projects.outputs.logging_bucket_project_id
#   name        = var.log_prj_bucket_name
#   retention   = var.retention_days
# }

module "logging_buckets" {
  source   = "../modules/logging-bucket"
  for_each = var.logging_buckets

  parent_type = each.value.parent_type
  parent      = data.terraform_remote_state.projects.outputs[each.value.project_id_key]
  name        = each.value.name
  retention   = each.value.retention
}

resource "google_logging_organization_sink" "org_sink" {
  name             = var.sink_name
  org_id           = var.org_id
  destination      = "logging.googleapis.com/${module.logging_buckets["log_bucket_4"].id}"
  include_children = true
  filter           = var.vpc_log_filter
}

resource "google_project_iam_member" "sink_writer" {
  project = data.terraform_remote_state.projects.outputs.logging_bucket_project_id
  role    = "roles/logging.bucketWriter"
  member  = google_logging_organization_sink.org_sink.writer_identity
}