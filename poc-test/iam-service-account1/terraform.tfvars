# -----------------------------------------------------------------------------
# CORE IDENTIFIERS
# -----------------------------------------------------------------------------

# Your Google Cloud Organization ID (e.g., 'organizations/1234567890')
organization_id = "1024767897869"

# The Google Cloud Project ID where service accounts will be created
project_id = "hub-network-1425566"


# -----------------------------------------------------------------------------
# ORGANIZATION CUSTOM ROLE DEFINITIONS (var.custom_roles)
#
# Define the permissions for custom roles by listing the predefined roles
# whose permissions should be merged.
# -----------------------------------------------------------------------------

service_custom_roles = {
  # Key: The custom role ID (will be prefixed with 'organizations/ORG_ID/roles/')
  # Value: List of predefined roles to merge permissions from
  "cloudcore_service_poc_account_role" = [
    "roles/iam.serviceAccountAdmin"
  ]
  "cloudcore_service_account_reader_role" = [
    "roles/iam.serviceAccountAdmin"
  ]
}


# -----------------------------------------------------------------------------
# ORGANIZATION MEMBER BINDINGS (var.custom_role_bindings)
#
# Bind the custom organization roles to users or groups (from your original code)
# -----------------------------------------------------------------------------

# custom_role_bindings = {
#   # Key: custom_role_id from the 'custom_roles' map above
#   # Value: List of members in the format: 'user:user@domain.com', 'group:group@domain.com', etc.
#   "data_reader_custom" = [
#     "user:john.doe@example.com",
#     "group:data-analysts@example.com"
#   ],
#   "storage_writer_custom" = [
#     "user:jane.smith@example.com"
#   ]
# }


# -----------------------------------------------------------------------------
# SERVICE ACCOUNT CREATION (var.service_accounts)
#
# Service accounts to be created in the specified project_id
# -----------------------------------------------------------------------------

service_accounts = {
  # Key: The desired service account ID (must be unique and < 30 chars)
  # Value: The display name
  "sa-reader-etl"       = "Service Account for ETL Reader Jobs",
  "sa-writer-reporting" = "Service Account for Reporting Writer",
  "sa-app-backend"      = "Service Account for Application Backend"
}


# -----------------------------------------------------------------------------
# SERVICE ACCOUNT ROLE BINDINGS (var.sa_role_bindings)
#
# Assign the organization custom roles (or any role) to the service accounts.
# -----------------------------------------------------------------------------

# sa_role_bindings = {
#   # Key: The custom role ID (must match a key in var.custom_roles, or be any valid role)
#   # Value: List of service account IDs (must match a key in var.service_accounts)

#   "data_reader_custom" = [
#     "sa-reader-etl",
#     "sa-app-backend"
#   ],
#   "storage_writer_custom" = [
#     "sa-writer-reporting"
#   ],
#   # Example of binding a standard predefined role too
#   "roles/iam.serviceAccountUser" = [
#     "sa-app-backend"
#   ]
# }