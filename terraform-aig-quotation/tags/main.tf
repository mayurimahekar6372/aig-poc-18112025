module "org_tags" {
  source          = "../modules/organization"
  organization_id = var.organization_id
  tags = var.tag_definitions
#   tags = {
#     environment = {
#         description = "Environment Specification"
#         values = {
#           dev = {
#             description = "Dev Resource"
#           }
#         }
#     }
#   }
#   context = {
#     tag_keys   = var.tag_keys
#     tag_values = var.tag_values
#   }
}
# tftest modules=1 resources=7 files=0,1 inventory=tags-factory.yaml