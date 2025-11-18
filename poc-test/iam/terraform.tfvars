organization_id = "organizations/1024767897869"

org_custom_roles = {
  "cloudcore_admin_role" = [
    "resourcemanager.folders.create",
    "resourcemanager.folders.delete",
    "resourcemanager.folders.deletePolicyBinding",
    "resourcemanager.folders.get",
    "resourcemanager.folders.getIamPolicy",
    "resourcemanager.folders.list",
    "resourcemanager.folders.move"
  ]
  "cloudcore_cloud_engineer_role" = [
    "resourcemanager.projects.get",
    "serviceusage.services.enable",
    "secretmanager.secrets.create",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.start",
    "compute.disks.create",
    "compute.networks.updatePolicy",
    "compute.subnetworks.use",
    "compute.firewalls.create",
    "compute.routes.create",
    "compute.urlMaps.create",
    "compute.forwardingRules.create",
    "storage.buckets.create",
    "storage.buckets.delete",
    "storage.objects.create",
    "storage.objects.delete",
    "monitoring.dashboards.create",
    "monitoring.alertPolicies.create"
  ]
}

org_role_assignments_config = {
  "cloudcore_admin_role"          = ["group:test-admin@ziyap.altostrat.com"]
  "cloudcore_cloud_engineer_role" = ["user:mayuri@ziyap.altostrat.com"]
}

project_custom_roles = {
  "gcp_prod_shared_core_network_viewer" = [
    "resourcemanager.projects.get",
    "resourcemanager.projects.getIamPolicy",
    "compute.networks.list",
    "compute.firewalls.list",
    "compute.routes.list",
    "compute.subnetworks.list"
  ]
}

project_role_assignments_config = {
  "gcp_prod_shared_core_network_viewer" = [
    "group:test-admin@ziyap.altostrat.com",
    "user:mayuri@ziyap.altostrat.com"
  ]
}