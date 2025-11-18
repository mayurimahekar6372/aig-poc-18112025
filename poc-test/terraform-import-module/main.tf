resource "google_org_policy_policy" "import_policy" {
  for_each = toset(var.org_policies)

  name   = "organizations/${var.organization_id}/policies/constraints/${each.key}"
  parent = "organizations/${var.organization_id}"

#   spec {
#     inherit_from_parent = false
#     reset               = false

#     rules {
#       enforce = true
#     }
#   }
}
