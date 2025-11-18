organization_id = "organizations/1024767897869"

# tag_keys = {
#   environment = "tagKeys/1234567890"
# }

# tag_values = {
#   "environment/production" = "tagValues/1234567890"
#   "environment/staging"    = "tagValues/1112223334"
# }

tag_definitions = {
  "environment" = {
    description = "Environment Specification"
    values = {
      "dev" = {
        description = "Dev Resource"
      }
    }
  }
  
  # Example of how you would add another tag key:
  "cost_center" = {
    description = "Cost Center for tracking"
    values = {
      "finance" = {
        description = "Finance Department"
      }
      "marketing" = {
        description = "Marketing Department"
      }
    }
  }
}