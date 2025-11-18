output "static_ip_addresses" {
  description = "static IP addresses created."
  value = merge([
    for module_instance in module.static_addresses :
    {
      for address_name, address_resource in module_instance.internal_addresses :
      address_name => address_resource.address
    }
  ]...)
}