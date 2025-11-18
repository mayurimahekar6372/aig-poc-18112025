# AIG Insurance Quotation Terraform Intrastructure

## Overview

This folder contains the Terraform infrastructure code for deploying the AIG Insurance Quotation application on Google Cloud Platform. It is structured to support HSS application with distinct application flows (Quotation and Transcription).

## Code Structure

```
/
├── artifact-registry/
│   ├── data.tf                  # Defines data sources, which fetch information about projects, regions, etc.
│   ├── main.tf                  # Contains the primary resource definitions for the artifact registry resource
│   └── outputs.tf               # Defines the values that will be exposed, which includes artifact registry resource name
├── firestore/
│   ├── data.tf                  # Defines data sources, which fetch information about projects, regions, etc.
│   ├── main.tf                  # Contains the primary resource definitions for the firestore resource
│   └── outputs.tf               # Defines the values that will be exposed, which includes firestore database name
├── gcs/
│   ├── data.tf                  # Defines data sources, which fetch information about projects, regions, etc.
│   ├── main.tf                  # Contains the primary resource definitions for the cloud storage resource
│   ├── outputs.tf               # Defines the values that will be exposed, which includes cloud storage bucket names
│   ├── terraform.tfvars         # contains the values for the input variables of CORS defined in variables.tf
│   └── variables.tf             # defines the input variables of CORS
├── net-lb-app-int/
│   ├── backend.tf               # Configures the remote backend for storing the terraform state file
│   ├── data.tf                  # Defines data sources, which fetch information about projects, regions, etc.
│   ├── main.tf                  # Contains the primary resource definitions for the internal load balancer resource
│   ├── outputs.tf               # Defines the values that will be exposed, which includes interal load balancer names
├── setup/
│   ├── post-setup/
│   │   ├── data.tf              # Defines data sources, which fetch information about projects, regions, etc.
│   │   └── main.tf              # Sets up IAM permissions for service accounts.
│   └── pre-setup/
│       ├── backend.tf           # Configures the remote backend for storing the Terraform state file
│       ├── data.tf              # Defines data sources, which fetch information about projects, regions, etc.
│       ├── main.tf              # Enables Google Cloud APIs and creates service accounts for application services
│       ├── outputs.tf           # Defines the values that will be exposed, which includes service account names, region, etc.
│       ├── terraform.tfvars     # Contains the values for the input variables of Region defined in variables.tf
│       └── variables.tf         # Defines the input variables of Region, which is used for all the resources of HSS
└── README.md                    # Contains the main documentation, setup instructions, and general information about the project.
```

## Building Steps

### Update Organization Policies
#### Assgign Organization Policy Administrator Role
1. Go to Google Cloud Console (https://console.cloud.google.com/)
2. Select org (ex: example.com) from the project selector at the top
3. Search for "IAM", and navigate to IAM page
4. Click the Edit principal button of the logged in user (ex: admin@example.com)
5. Click Add roles, and search for Organization Policy Administrator
6. Click "Apply" and "Save" button at the bottom
#### Update Policy for "Domain restricted sharing"
1. Select project (ex: tf-aig-dev) from the project selector at the top
2. Search for "Organization Policies", and navigate to Organization Policies page
3. Filter by **iam.allowedPolicyMemberDomains**
4. Click “Domain restricted sharing”
5. Click “manage policy” in Policy for "Domain restricted sharing" page
    1. Policy source: Override parent's policy
    2. Click “Edit Policy enforcement: Replace
    3. Click “Save Rules: Add a rule - Policy values: Allow All
6. Click “Set policy” button

### Update variable values in terraform.tfvars
1. Update Region values in setup/pre-setup folder
    1. region: (ex: "asia-northeast1")
2. Update CORS values in gcs folder
    1. origin: (ex: "*")
    2. method: (ex: "PUT")
    3. reponse_header: (ex: "Content-Type")
    4. max_age_seconds: (ex: 3600)

### Update terraform remote state bucket path in data.tf and backend.tf
1. Update terraform remote state bucket path 
    1. bucket: 

### Run Terraform commands to build the environment
1. Open a terminal
2. Run gcloud commands below
    1. Authenticate the gcloud CLI with user credentials
        ```bash
        gcloud auth login
        ```
    2. Set up credentials (ADC) for tools like Terraform to access Google Cloud APIs
        ```bash
        gcloud auth application-default login
        ```
3. Move to the pre-setup folder (ex: terraform-aig-quotation/application-[applicaiton-name]/setup/pre-setup) application-name: (ex: hss/lynx)
4. Run Terraform commands below
    1.  Initialize the working directory and download necessary provider plugins
        ```bash
        terraform init
        ```
    2. Generate and display the execution plan of changes to be applied to the infrastructure
        ```bash
        terraform plan
        ```
    3. Execute the plan and create, modify, or delete resources in the cloud infrastructure
        ```bash
        terraform apply
        ```
5. Type “yes” and proceed
7. Repeat from 3. for folders of artifact-registry, firestore, and gcs to provision artifact registry, firestore, and cloud storage services
7. Wait until application team deploys cloud run, workflows, etc.
8. Repeat from 3. for folders of net-lb-app-int to privision internal load balancer service
9. Repeat from 3. for folder of setup/post-setup to sets up IAM permissions for service accounts

