output "workforce_pool_id" {
  description = "The ID of the created Workforce Pool."
  value       = try(google_iam_workforce_pool.pool[0].workforce_pool_id, "")
}

output "workforce_pool_name" {
  description = "The full resource name of the Workforce Pool (e.g., organizations/ORG_ID/locations/global/workforcePools/POOL_ID)."
  value       = try(google_iam_workforce_pool.pool[0].name, "")
}

output "provider_name" {
  description = "The full resource name of the Provider (e.g., .../providers/PROVIDER_ID)."
  value       = try(google_iam_workforce_pool_provider.okta_provider[0].name, "")
}