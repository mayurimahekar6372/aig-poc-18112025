organization_id = "organizations/1024767897869"
# org_policies = [
#   "storage.publicAccessPrevention",
#   "gcp.resourceLocations" 
# ]

org_policies = {
  "storage.publicAccessPrevention" = {
    rules = [{ enforce = true }]
  }
  "gcp.resourceLocations" = {
    inherit_from_parent = true
    rules = [{
      allow = {
        values = ["us-central1", "asia-northeast1"]
      }
    }]
  }
}
