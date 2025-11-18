organization_id = "organizations/1024767897869"
org_policies = {
  "storage.publicAccessPrevention" = {
    rules = [{ enforce = true }]
  }
  "iam.allowedPolicyMemberDomains"     = {} # Check on AIG and then import
  "compute.skipDefaultNetworkCreation" = {} # Imported
  # "cloudbuild.useBuildServiceAccount" = {
  #   rules = [{
  #     enforce = true
  #   }]
  # }
  "cloudbuild.useComputeServiceAccount" = {
    rules = [{
      enforce = true
    }]
  }
  "compute.sharedReservationsOwnerProjects" = {
    rules = [{
      deny = {
        all = true
      }
    }]
  }
  "iam.serviceAccountKeyExposureResponse" = {
    rules = [{
      allow = {
        values = ["DISABLE_KEY"]
      }
    }]
  }
  "appengine.runtimeDeploymentExemption" = {
    rules = [{
      deny = {
        all = true
      }
    }]
  }
  "commerceorggovernance.marketplaceServices" = {
    rules = [{
      deny = {
        all = true
      }
    }]
  }
  "resourcemanager.allowEnabledServicesForExport" = {
    rules = [{
      deny = {
        all = true
      }
    }]
  }
  "cloudbuild.disableCreateDefaultServiceAccount" = {
    rules = [{
      enforce = true
    }]
  }
  "iam.managed.disableServiceAccountApiKeyCreation" = {
    rules = [{
      enforce = true
    }]
  }
  "compute.managed.blockPreviewFeatures" = {
    rules = [{
      enforce = true
    }]
  }
  "resourcemanager.allowedImportSources" = {
    rules = [{
      deny = {
        all = true
      }
    }]
  }
  "resourcemanager.allowedExportDestinations" = {
    rules = [{
      deny = {
        all = true
      }
    }]
  }
  "iam.allowServiceAccountCredentialLifetimeExtension" = {
    rules = [{
      deny = {
        all = true
      }
    }]
  }
  # "dry_run:iam.managed.disableServiceAccountApiKeyCreation" = {
  #   rules = [{
  #     enforce = true
  #   }]
  # }
}

folder_org_policies = {
  "compute.managed.vmExternalIpAccess" = {
    rules = [{ enforce = true }]
  }
  # "iam.allowedPolicyMemberDomains" = {
  #   rules = [{
  #     allow = {
  #       all = true
  #     }
  #   }]
  # }
}