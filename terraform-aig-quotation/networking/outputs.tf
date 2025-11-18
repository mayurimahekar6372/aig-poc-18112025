output "non_prod_vpc_self_link" {
  description = "The self-link of the non-prod host VPC."
  value       = module.non_prod_vpc_host.self_link
}

output "hub_vpc_self_link" {
  description = "The self-link of the hub VPC."
  value       = module.vpc-hub-network.self_link
}

output "non_prod_vpc_name" {
  description = "The name of the non-prod host VPC."
  value       = module.non_prod_vpc_host.name # Assumes your module outputs the VPC name
}


# ADD THIS NEW OUTPUT BLOCK
output "non_prod_subnet_self_link" {
  description = "The self-link of the non-prod host VPC's primary subnet."
  # This assumes your net-vpc module outputs subnet details.
  # We are getting the self_link of the first subnet in the list.
  value = values(module.non_prod_vpc_host.subnets)[0].self_link
}


# ADD THIS NEW OUTPUT BLOCK
output "hub_vpc_name" {
  description = "The name of the hub VPC."
  value       = module.vpc-hub-network.name
}

# In ./03-networking/outputs.tf

# ADD THIS NEW OUTPUT BLOCK
output "hub_subnet_self_link" {
  description = "The self-link of the hub VPC's primary subnet."
  value       = values(module.vpc-hub-network.subnets)[0].self_link
}

output "non_prod_psc_subnet_self_link" {
  description = "The self-link of the non prod VPC's PSC Subnet"
  value       = values(module.non_prod_vpc_host.subnets_psc)[0].self_link
}

output "non_prod_regional_managed_proxy_subnet_self_link" {
  description = "The self-link of the non prod VPC's Regional Managed Proxy Subnet"
  value       = values(module.non_prod_vpc_host.subnets_proxy_only)[0].self_link
}