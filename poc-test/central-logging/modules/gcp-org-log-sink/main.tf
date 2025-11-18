# This resource creates the aggregated sink at the organization level
resource "google_organization_log_sink" "org_sink" {
  name             = var.sink_name
  org_id           = var.org_id
  destination      = var.destination_bucket_id
  filter           = var.filter
  include_children = true
}