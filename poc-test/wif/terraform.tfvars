# ---------------------------------
# YOUR VALUES GO HERE
# ---------------------------------

gcp_project_id = "your-gcp-project-id"

# The path to the file from your Okta team.
# This path is relative to this file.
okta_metadata_file = "okta-metadata.xml"

# Define your role-to-group mappings here
okta_group_permissions = {
  "roles/compute.viewer" = ["gcp-developers", "gcp-auditors"]
  "roles/storage.admin"  = ["gcp-storage-admins"]
  "roles/browser"        = ["gcp-developers"]
}


organization_id = "1024767897869"