# Centralized GCP VPC Flow Logs with Terraform

This repository contains the Terraform code to set up a centralized logging solution for GCP VPC Flow Logs.

It uses an organization-level aggregated sink to capture logs from all projects (current and future) and routes them to a dedicated, long-term log bucket in a central logging project. This pattern is built using a "root/child" module strategy for maximum reusability and clean separation of concerns.

---

## 🏛️ Architecture & Deployment Strategy

This setup is deployed in multiple, distinct stages to solve a "circular dependency":

1.  The **Log Sink** (in the Org) needs to know the **Log Bucket's ID** to send logs to it.
2.  The **Log Bucket** (in the Logging Project) needs to know the **Sink's Service Account (`writer_identity`)** to grant it write permissions.

We break this cycle by deploying the infrastructure in three main stages, followed by the application projects:

1.  **Deploy Bucket:** Create the destination log bucket.
2.  **Deploy Sink:** Create the organization sink, which now has the bucket's ID. This action *generates* the `writer_identity` service account.
3.  **Deploy IAM "Glue":** Apply an IAM binding that gives the `writer_identity` (from Step 2) permission to write to the bucket (from Step 1).



---

## 📁 Directory Structure

gcp-infra-fabric/ ├── 📂 modules/ │ ├── 📄 gcp-logging-bucket/ │ │ ├── main.tf │ │ ├── variables.tf │ │ └── outputs.tf │ └── 📄 gcp-org-log-sink/ │ ├── main.tf │ ├── variables.tf │ └── outputs.tf │ └── 📂 stacks/ ├── 📄 1-central-logging/ │ ├── main.tf │ ├── terraform.tfvars │ ├── variables.tf │ └── outputs.tf ├── 📄 2-organization/ │ ├── main.tf │ ├── terraform.tfvars │ ├── variables.tf │ └── outputs.tf ├── 📄 3-logging-iam/ │ ├── main.tf │ ├── provider.tf │ └── variables.tf └── 📄 4-my-app-project/ ├── main.tf ├── terraform.tfvars └── variables.tf

## 🚀 Deployment Steps

### Prerequisites

1.  **Terraform:** `v1.3+` installed.
2.  **Google Cloud SDK:** `gcloud` CLI installed and authenticated (`gcloud auth application-default login`).
3.  **Terraform Backend:** A GCS bucket for storing Terraform state. You must update the `backend "gcs" { ... }` block in each stack to point to your state bucket.
4.  **Permissions:** You must have the necessary IAM permissions to manage resources at the Organization level (`Organization Admin`, `Logging Admin`) and in the component projects (`Project Owner`, `Project IAM Admin`).

### Deployment Order

You must deploy these stacks in the following order.

#### Step 1: Deploy the Central Log Bucket

This stack creates the central GCP project (if needed) and the dedicated log bucket.

```bash
# Navigate to the first stack
cd stacks/1-central-logging

# (Optional) Update terraform.tfvars with your project ID
# project_id     = "my-central-logging-project"
# bucket_name    = "vpc-flow-logs-bucket"
# retention_days = 365

# Initialize and apply
terraform init
terraform apply