service_account_name = {
  "my-data-reader-sa"    = "Data Reader Service Account"
  "my-backend-writer-sa" = "Backend Writer Service Account"
}

service_account_custom_roles = {
  "cloudcore_sa_reader_role" = [
    "roles/compute.viewer",
    "roles/storage.objectViewer"
  ]
  "cloudcore_sa_writer_role" = [
    "roles/storage.objectAdmin",
    "roles/pubsub.editor"
  ]
}

service_account_role_bindings = {
  "cloudcore_sa_reader_role" : [
    "my-data-reader-sa",
    "my-backend-writer-sa"
  ],
  "cloudcore_sa_writer_role" : [
    "my-backend-writer-sa"
  ]
}