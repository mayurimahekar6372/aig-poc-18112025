organization_id   = "organizations/1024767897869"
pool_id           = "xyzc-pool"
pool_display_name = "XYZ Pool"

provider_id           = "okta-provider"
provider_display_name = "Okta Provider"
okta_metadata_file    = "okta-metadata.xml"
okta_group_permissions = {
  "roles/compute.viewer" = ["gcp-developers", "gcp-auditors"]
  "roles/storage.admin"  = ["gcp-storage-admins"]
  "roles/browser"        = ["gcp-developers"]
}
attribute_mapping = {
  # Maps the SAML 'NameID' to Google's unique subject
  "google.subject" = "assertion.subject.NameID"

  # Maps the SAML attribute for email
  "google.email" = "assertion.attributes['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress']"

  # Maps the SAML attribute for groups
  "google.groups" = "assertion.attributes.groups"

  # Optional: maps the SAML attribute for display name
  "google.display_name" = "assertion.attributes.displayName"

}