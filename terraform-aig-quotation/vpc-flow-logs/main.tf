module "organization_vpc_flow_logs" {
  source                  = "../modules/vpc-flow-logs"
  organization_id         = var.organization_id
  vpc_flow_logs_config_id = var.vpc_flow_logs_config_id
  aggregation_interval    = var.aggregation_interval
  flow_sampling           = var.flow_sampling
  cross_project_metadata  = var.cross_project_metadata
  state                   = "ENABLED"
  labels                  = var.labels
}