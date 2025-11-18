resource "google_network_management_organization_vpc_flow_logs_config" "vpc_flow_logs" {
  provider                = google-beta
  organization            = var.organization_id
  location                = var.flow_logs_location
  vpc_flow_logs_config_id = var.vpc_flow_logs_config_id
  description             = var.description
  state                   = var.state
  aggregation_interval    = var.aggregation_interval
  flow_sampling           = var.flow_sampling
  metadata                = var.metadata
  metadata_fields         = var.metadata_fields
  filter_expr             = var.filter_expr
  cross_project_metadata  = var.cross_project_metadata
  labels                  = var.labels
}