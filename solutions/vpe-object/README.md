# Cloud automation for Catalog Management (VPE object variation)

This solution supports provisioning and configuring an IBM Cloud catalog VPE object.

:exclamation: **Important:** This solution is not intended to be called by other modules because it contains a provider configuration and is not compatible with the `for_each`, `count`, and `depends_on` arguments. For more information, see [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers).

![vpe](../../reference-architecture/vpe.svg)

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.78.3 |

### Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpe_object"></a> [vpe\_object](#module\_vpe\_object) | ../../modules/vpe-catalog-object | n/a |

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalog_id"></a> [catalog\_id](#input\_catalog\_id) | Catalog identifier. | `string` | n/a | yes |
| <a name="input_dns_domain"></a> [dns\_domain](#input\_dns\_domain) | DNS domain for the VPE to create. | `string` | n/a | yes |
| <a name="input_endpoint_type"></a> [endpoint\_type](#input\_endpoint\_type) | What the VPE exposes, one of api, config, firewall. | `string` | `"api"` | no |
| <a name="input_fully_qualified_domain_names"></a> [fully\_qualified\_domain\_names](#input\_fully\_qualified\_domain\_names) | list of FQDNs to map to the VPE object. | `list(string)` | `[]` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | The IBM Cloud API key used to provision resources. | `string` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | Display name. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The programmatic name of this VPE catalog object. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The parent region for this specific object. | `string` | n/a | yes |
| <a name="input_service_crn"></a> [service\_crn](#input\_service\_crn) | CRN of the service to map on VPE entry and on VPE gateway. | `string` | n/a | yes |
| <a name="input_short_description"></a> [short\_description](#input\_short\_description) | Short description. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags associated with this object. | `list(string)` | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_crn"></a> [crn](#output\_crn) | CRN associated with the object. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the object. |
| <a name="output_label"></a> [label](#output\_label) | Display Name. |
| <a name="output_name"></a> [name](#output\_name) | The programmatic name of this object |
| <a name="output_publish"></a> [publish](#output\_publish) | Publish information. |
| <a name="output_url"></a> [url](#output\_url) | The url for this specific object. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
