output "vpc_flow_logs_config_id" {
  description = "The full unique ID (URI) of the Organization VPC Flow Logs Configuration resource."
  value       = module.organization_vpc_flow_logs.vpc_flow_logs.id
}

output "vpc_flow_logs_config_labels" {
  description = "The user-defined labels applied to the VPC Flow Logs Configuration resource."
  value       = module.organization_vpc_flow_logs.vpc_flow_logs.labels
}

output "vpc_flow_logs_config_settings" {
  description = "Key configuration settings for the VPC Flow Logs (sampling, aggregation, metadata)."
  value = {
    aggregation_interval   = module.organization_vpc_flow_logs.vpc_flow_logs.aggregation_interval
    flow_sampling          = module.organization_vpc_flow_logs.vpc_flow_logs.flow_sampling
    metadata_setting       = module.organization_vpc_flow_logs.vpc_flow_logs.metadata
    cross_project_metadata = module.organization_vpc_flow_logs.vpc_flow_logs.cross_project_metadata
  }
}