output "enabled_apis" {
  description = "A map of the API services that were enabled, keyed by service name."
  value = {
    for k, v in google_project_service.enabled_apis : k => v.service
  }
}