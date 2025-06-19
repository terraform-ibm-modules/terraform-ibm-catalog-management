# Cloud automation for Catalog Management (catalog variation)

This solution supports provisioning and configuring an IBM Cloud catalog.

:exclamation: **Important:** This solution is not intended to be called by other modules because it contains a provider configuration and is not compatible with the `for_each`, `count`, and `depends_on` arguments. For more information, see [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers).

![catalog](../../reference-architecture/catalog.svg)

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
| <a name="module_catalog"></a> [catalog](#module\_catalog) | ../.. | n/a |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform-ibm-modules/resource-group/ibm | 1.2.0 |

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalog_banner_url"></a> [catalog\_banner\_url](#input\_catalog\_banner\_url) | URL for a banner image for this catalog. | `string` | `null` | no |
| <a name="input_catalog_icon_url"></a> [catalog\_icon\_url](#input\_catalog\_icon\_url) | URL for an icon associated with this catalog. | `string` | `null` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | Denotes whether a catalog is disabled. | `bool` | `false` | no |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | The name of an existing resource group to provision resource in. | `string` | `"Default"` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | The IBM Cloud API key used to provision resources. | `string` | n/a | yes |
| <a name="input_kind"></a> [kind](#input\_kind) | Kind of catalog. Supported kinds are 'offering' and 'vpe'. | `string` | `"offering"` | no |
| <a name="input_label"></a> [label](#input\_label) | Display name for the catalog. | `string` | n/a | yes |
| <a name="input_short_description"></a> [short\_description](#input\_short\_description) | A description of the catalog. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags associated with this catalog. | `list(string)` | `[]` | no |
| <a name="input_target_accounts"></a> [target\_accounts](#input\_target\_accounts) | List of target accounts to add to this catalog. Can only be configured on an update, not on a create. | <pre>list(object({<br/>    api_key            = optional(string)<br/>    name               = string<br/>    label              = string<br/>    project_id         = optional(string)<br/>    trusted_profile_id = optional(string)<br/>    target_service_id  = optional(string)<br/>  }))</pre> | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_crn"></a> [crn](#output\_crn) | CRN associated with the catalog. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the catalog. |
| <a name="output_label"></a> [label](#output\_label) | Display Name. |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | Resource group ID. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource group name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
