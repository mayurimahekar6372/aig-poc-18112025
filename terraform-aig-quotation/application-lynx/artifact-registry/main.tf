module "docker_artifact_registry" {
  source = "../../modules/artifact-registry"

  project_id = var.project_id
  location   = var.region
  name       = var.repository_name
  format     = { docker = { standard = {} } }
}