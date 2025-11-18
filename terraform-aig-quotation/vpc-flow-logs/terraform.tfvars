organization_id         = "1024767897869"
vpc_flow_logs_config_id = "org-network-traffic-monitor"

# Aggregation interval: How frequently sampled packets are aggregated into a single log entry.
# Possible values: INTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN
aggregation_interval = "INTERVAL_30_SEC"

# Flow Sampling Rate: The percentage of flow logs retained (0.0 < value <= 1.0).
flow_sampling = 0.8 # Represents 80% sampling

# Cross-Project Metadata: Whether to include metadata (like firewall rules) from resources in other projects.
# Possible values: CROSS_PROJECT_METADATA_ENABLED, CROSS_PROJECT_METADATA_DISABLED
cross_project_metadata = "CROSS_PROJECT_METADATA_ENABLED"

# Optional: Custom labels applied to the VPC Flow Logs Configuration resource itself.
labels = {
  bu-environment-type = "non-prod"
  bu-application-name = "google-cloud-platform"
}