<!-- BEGIN_TF_DOCS -->
# Folder Creation

## Overview
This Terraform configuration establishes a foundational and structured folder hierarchy within a Google Cloud Platform (GCP) organization.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gi_folder"></a> [gi\_folder](#module\_gi\_folder) | ../modules/folder | n/a |
| <a name="module_gi_japan_folder"></a> [gi\_japan\_folder](#module\_gi\_japan\_folder) | ../modules/folder | n/a |
| <a name="module_gi_japan_non_prod_folder"></a> [gi\_japan\_non\_prod\_folder](#module\_gi\_japan\_non\_prod\_folder) | ../modules/folder | n/a |
| <a name="module_hub_network_folder"></a> [hub\_network\_folder](#module\_hub\_network\_folder) | ../modules/folder | n/a |
| <a name="module_non_prod_folder"></a> [non\_prod\_folder](#module\_non\_prod\_folder) | ../modules/folder | n/a |
| <a name="module_non_prod_host_folder"></a> [non\_prod\_host\_folder](#module\_non\_prod\_host\_folder) | ../modules/folder | n/a |
| <a name="module_non_prod_service_folder"></a> [non\_prod\_service\_folder](#module\_non\_prod\_service\_folder) | ../modules/folder | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_parent_folder"></a> [parent\_folder](#input\_parent\_folder) | The parent folder for the 'non-prod' and 'hub-network' folders. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gi_folder_id"></a> [gi\_folder\_id](#output\_gi\_folder\_id) | n/a |
| <a name="output_gi_japan_folder_id"></a> [gi\_japan\_folder\_id](#output\_gi\_japan\_folder\_id) | n/a |
| <a name="output_gi_japan_non_prod_folder_id"></a> [gi\_japan\_non\_prod\_folder\_id](#output\_gi\_japan\_non\_prod\_folder\_id) | n/a |
| <a name="output_hub_network_folder_id"></a> [hub\_network\_folder\_id](#output\_hub\_network\_folder\_id) | n/a |
| <a name="output_non_prod_host_folder_id"></a> [non\_prod\_host\_folder\_id](#output\_non\_prod\_host\_folder\_id) | n/a |
| <a name="output_non_prod_service_folder_id"></a> [non\_prod\_service\_folder\_id](#output\_non\_prod\_service\_folder\_id) | n/a |
<!-- END_TF_DOCS -->