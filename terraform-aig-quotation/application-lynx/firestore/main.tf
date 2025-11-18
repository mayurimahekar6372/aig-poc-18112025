module "firestore" {
  source = "../../modules/firestore"

  project_id = var.project_id
  database = {
    name        = var.database_name
    location_id = var.region
    type        = "FIRESTORE_NATIVE"
  }
}