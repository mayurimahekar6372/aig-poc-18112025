organization_id = "1024767897869"

billing_project = "terraform-473206"

org_custom_roles = {
  "cloudcore_admin_role" = [
    "roles/resourcemanager.organizationAdmin",
    "roles/billing.admin",
    "roles/iam.organizationRoleAdmin",
    "serviceusage.services.enable",
    "serviceusage.services.list",
    "roles/billing.viewer",
    "billing.anomaliesConfigs.get"
  ]
  "cloudcore_cloud_engineer_role" = [
    "roles/compute.admin",
    "roles/storage.admin",
    "roles/container.admin",
    "roles/cloudsql.admin",
    "roles/pubsub.admin",
    "roles/logging.configWriter",
    "roles/iam.serviceAccountUser",
  ]
  "cloudcore_billing_administrator_role" = [
    "roles/billing.admin",
  ]
  "cloudcore_network_administrator_role" = [
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin",
    "roles/dns.admin",
    "roles/logging.viewer",
  ]
  "cloudcore_cloud_reader_role" = [
    "roles/compute.viewer",
    "roles/storage.objectViewer",
    "roles/container.viewer",
    "roles/cloudsql.viewer",
    "roles/monitoring.viewer",
    "roles/logging.viewer",
    "roles/billing.viewer",
    "roles/resourcemanager.folderViewer",
    "roles/browser",
    "roles/cloudbuild.builds.viewer"
  ]
  "cloudcore_cloud_ops_1_role" = [
    "roles/monitoring.viewer",
    "roles/logging.viewer",
    "roles/compute.viewer",
    "roles/storage.objectViewer",
    "roles/errorreporting.viewer",
  ]
  "cloudcore_cloud_ops_2_role" = [
    # Includes all L1 permissions plus editor/operator roles
    "roles/monitoring.viewer",
    "roles/logging.viewer",
    "roles/storage.objectViewer",
    "roles/errorreporting.viewer",
    "roles/compute.instanceAdmin.v1",
    "roles/pubsub.editor",
    "roles/cloudsql.editor",
    "roles/container.developer",
  ]
}

org_role_bindings = {
  "cloudcore_admin_role" = [
    "user:mayuri@ziyap.altostrat.com"
  ],
  "cloudcore_cloud_reader_role" = [
    "group:test-admin@ziyap.altostrat.com",
    "user:mayuri@ziyap.altostrat.com"
  ]
}

hub_project_custom_roles = {
  "cloudcore_project_viewer" = [
    "roles/compute.viewer",
    "roles/storage.objectViewer",
    "roles/container.viewer",
    "roles/cloudsql.viewer",
    "roles/monitoring.viewer",
    "roles/logging.viewer",
    "roles/browser",
    "roles/cloudbuild.builds.viewer",
    "serviceusage.services.enable",
    "serviceusage.services.list",
    "serviceusage.services.disable"
  ]
}

hub_project_excluded_permissions = []

hub_project_role_bindings = {
  "cloudcore_project_viewer" = [
    "group:test-admin@ziyap.altostrat.com",
    "user:mayuri@ziyap.altostrat.com"
  ]
}

organization_excluded_permissions = [
  "appengine.runtimes.actAsAdmin",
  "cloudasset.assets.analyzeIamPolicy",
  "cloudmigration.velostrataendpoints.connect",
  "cloudonefs.isiloncloud.com/clusters.create",
  "cloudonefs.isiloncloud.com/clusters.delete",
  "cloudonefs.isiloncloud.com/clusters.get",
  "cloudonefs.isiloncloud.com/clusters.list",
  "cloudonefs.isiloncloud.com/clusters.update",
  "cloudonefs.isiloncloud.com/clusters.updateAdvancedSettings",
  "cloudonefs.isiloncloud.com/fileshares.create",
  "cloudonefs.isiloncloud.com/fileshares.delete",
  "cloudonefs.isiloncloud.com/fileshares.get",
  "cloudonefs.isiloncloud.com/fileshares.list",
  "cloudonefs.isiloncloud.com/fileshares.update",
  "dataplex.assets.ownData",
  "dataplex.assets.readData",
  "dataplex.assets.writeData",
  "domains.registrations.configureContact",
  "domains.registrations.configureDns",
  "domains.registrations.configureManagement",
  "domains.registrations.create",
  "domains.registrations.delete",
  "domains.registrations.get",
  "domains.registrations.getIamPolicy",
  "domains.registrations.list",
  "domains.registrations.setIamPolicy",
  "domains.registrations.update",
  "gcp.redisenterprise.com/databases.create",
  "gcp.redisenterprise.com/databases.delete",
  "gcp.redisenterprise.com/databases.get",
  "gcp.redisenterprise.com/databases.list",
  "gcp.redisenterprise.com/databases.update",
  "gcp.redisenterprise.com/subscriptions.create",
  "gcp.redisenterprise.com/subscriptions.delete",
  "gcp.redisenterprise.com/subscriptions.get",
  "gcp.redisenterprise.com/subscriptions.list",
  "gcp.redisenterprise.com/subscriptions.update",
  "gkehub.fleet.create",
  "gkehub.fleet.delete",
  "gkehub.fleet.get",
  "gkehub.fleet.update",
  "source.repos.update",
  "stackdriver.projects.edit",
  "storagetransfer.agentpools.report",
  "storagetransfer.operations.assign",
  "storagetransfer.operations.report",
  "telcoautomation.edgeSlms.create",
  "billing.anomalies.get",
  "billing.anomalies.list",
  "billing.anomaliesConfigs.get"

]