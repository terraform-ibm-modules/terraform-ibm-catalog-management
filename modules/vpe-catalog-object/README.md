# VPE Catalog object module

Automation to manage an IBM Cloud VPE catalog object.

### Usage

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

locals {
    region = "us-south"
}

provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXX"  # replace with apikey value
  region           = local.region
}

module "vpe_catalog_object" {
  source                       = "terraform-ibm-modules/catalog-management/ibm//modules/vpe-catalog-object"
  version                      = "X.Y.Z" # Replace "X.Y.Z" with a release version to lock into a specific release
  name                         = "my-programmatic-name"
  label                        = "My VPE Object"
  region                       = local.region
  catalog_id                   = "xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX" # Replace with the actual ID of the catalog
  endpoint_type                = "api" # also supports "config", "firewall", "vpe"
  dns_domain                   = "example.com"
  fully_qualified_domain_names = ["catalog-object-fqdn.example.com", "catalog-object-fqdn-v2.example.com"]
  service_crn                  = "crn:v1:bluemix:public:service:global:::endpoint:test.private.example.com"
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
| [ibm_cm_object.cm_object](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cm_object) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_catalog_id"></a> [catalog\_id](#input\_catalog\_id) | Catalog identifier. | `string` | n/a | yes |
| <a name="input_dns_domain"></a> [dns\_domain](#input\_dns\_domain) | DNS domain for the VPE to create. | `string` | n/a | yes |
| <a name="input_endpoint_type"></a> [endpoint\_type](#input\_endpoint\_type) | What the VPE exposes, one of api, config, firewall. | `string` | `"api"` | no |
| <a name="input_fully_qualified_domain_names"></a> [fully\_qualified\_domain\_names](#input\_fully\_qualified\_domain\_names) | list of FQDNs to map to the VPE object. | `list(string)` | `[]` | no |
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
