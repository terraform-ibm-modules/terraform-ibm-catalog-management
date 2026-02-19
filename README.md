# Catalog management module

[![Graduated (Supported)](https://img.shields.io/badge/Status-Graduated%20(Supported)-brightgreen)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-catalog-management?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-catalog-management/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-623CE4?logo=terraform)](https://registry.terraform.io/modules/terraform-ibm-modules/catalog-management/ibm/latest)

Automation to manage an IBM Cloud catalog.

<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-catalog-management](#terraform-ibm-catalog-management)
* [Submodules](./modules)
    * [vpe-catalog-object](./modules/vpe-catalog-object)
* [Examples](./examples)
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
    * <a href="./examples/offering-catalog">Offering catalog example</a> <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=catalog-management-offering-catalog-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-catalog-management/tree/main/examples/offering-catalog"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom; margin-left: 5px;"></a>
    * <a href="./examples/vpe-catalog">VPE object example</a> <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=catalog-management-vpe-catalog-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-catalog-management/tree/main/examples/vpe-catalog"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom; margin-left: 5px;"></a>
* [Deployable Architectures](./solutions)
    * <a href="./solutions/catalog">Cloud automation for Catalog Management (catalog variation)</a>
    * <a href="./solutions/vpe-object">Cloud automation for Catalog Management (VPE object variation)</a>
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->

## terraform-ibm-catalog-management

### Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->

```hcl
terraform {
  required_version = ">= 1.9.0"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "X.Y.Z"  # Lock into a provider version that satisfies the module constraints
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXX"  # replace with apikey value
}

module "catalog" {
  source            = "terraform-ibm-modules/catalog-management/ibm"
  version           = "X.Y.Z" # Replace "X.Y.Z" with a release version to lock into a specific release
  label             = "My catalog"
  kind              = "offering"
  resource_group_id = "xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX" # Replace with the actual ID of resource group to use
}
```

### Required access policies

You need the following permissions to run this module:

- Service
    - **Resource group only**
        - `Viewer` access on the specific resource group
    - **Catalog Management** service
        - `Editor` platform access

<!-- The following content is automatically populated by the pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.79.0, < 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cm_catalog.cm_catalog](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_catalog) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalog_banner_url"></a> [catalog\_banner\_url](#input\_catalog\_banner\_url) | URL for a banner image for this catalog. | `string` | `null` | no |
| <a name="input_catalog_icon_url"></a> [catalog\_icon\_url](#input\_catalog\_icon\_url) | URL for an icon associated with this catalog. | `string` | `null` | no |
| <a name="input_disabled"></a> [disabled](#input\_disabled) | Denotes whether a catalog is disabled. | `bool` | `false` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | Kind of catalog. Supported kinds are 'offering' and 'vpe'. | `string` | `"offering"` | no |
| <a name="input_label"></a> [label](#input\_label) | Display name for the catalog. | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | Resource group id the catalog is owned by. | `string` | n/a | yes |
| <a name="input_short_description"></a> [short\_description](#input\_short\_description) | A description of the catalog. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags associated with this catalog. | `list(string)` | `[]` | no |
| <a name="input_target_accounts"></a> [target\_accounts](#input\_target\_accounts) | List of target accounts to add to this catalog. Can only be configured on an update, not on a create. | <pre>list(object({<br/>    api_key            = optional(string)<br/>    name               = string<br/>    label              = string<br/>    project_id         = optional(string)<br/>    trusted_profile_id = optional(string)<br/>    target_service_id  = optional(string)<br/>  }))</pre> | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_catalog_banner_url"></a> [catalog\_banner\_url](#output\_catalog\_banner\_url) | The url of the catalog banner. |
| <a name="output_catalog_icon_url"></a> [catalog\_icon\_url](#output\_catalog\_icon\_url) | The url of the catalog icon. |
| <a name="output_crn"></a> [crn](#output\_crn) | CRN associated with the catalog. |
| <a name="output_id"></a> [id](#output\_id) | The unique identifier of the catalog. |
| <a name="output_label"></a> [label](#output\_label) | Display Name. |
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | Resource group id the catalog is owned by. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set-up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
