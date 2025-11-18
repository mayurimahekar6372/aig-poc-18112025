output "workforce_pool_id" {
  description = "The ID of the created Workforce Pool."
  value       = module.workforce_pool.workforce_pool_id
}

output "workforce_pool_name" {
  description = "The full resource name of the created Workforce Pool."
  value       = module.workforce_pool.workforce_pool_name
}

output "provider_name" {
  description = "The full resource name of the SAML provider."
  value       = module.okta_federation_provider.provider_name
}