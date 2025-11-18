module "org_policies" {
  source          = "../terraform-aig-quotation/modules/organization"
  organization_id = var.organization_id
  org_policies    = var.org_policies
}
