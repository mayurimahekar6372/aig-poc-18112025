# log_bucket_name     = "_Default"
# retention_days      = 60
# log_prj_bucket_name = "aig-core-prod-logs"

org_id         = "1024767897869"
sink_name      = "org-wide-vpc-flow-logs"
vpc_log_filter = "logName:networkmanagement.googleapis.com%2Fvpc_flows"

logging_buckets = {
  log_bucket_1 = {
    parent_type    = "project"
    project_id_key = "hub_network_project_id" # Corresponds to remote state output
    name           = "_Default"
    retention      = 90
  },
  log_bucket_2 = {
    parent_type    = "project"
    project_id_key = "non_prod_host_project_id"
    name           = "_Default"
    retention      = 90
  },
  log_bucket_3 = {
    parent_type    = "project"
    project_id_key = "non_prod_service_project_id"
    name           = "_Default"
    retention      = 90
  },
  log_bucket_4 = {
    parent_type    = "project"
    project_id_key = "logging_bucket_project_id"
    name           = "aig-core-prod-bkt"
    retention      = 90
  }
}