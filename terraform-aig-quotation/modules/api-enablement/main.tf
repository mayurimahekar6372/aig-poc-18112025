# -----------------------------------------------------------------------------
# Enables a list of Google Cloud APIs on a project.
# -----------------------------------------------------------------------------

resource "google_project_service" "enabled_apis" {
  for_each = toset(coalesce(var.services, []))

  project                    = var.project_id
  service                    = each.value
  disable_on_destroy         = var.disable_on_destroy
  disable_dependent_services = var.disable_dependent_services
}