# Cloud automation for Catalog Management (VPE object variation)

This solution supports provisioning and configuring an IBM Cloud catalog VPE object.

:exclamation: **Important:** This solution is not intended to be called by other modules because it contains a provider configuration and is not compatible with the `for_each`, `count`, and `depends_on` arguments. For more information, see [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers).

![vpe](../../reference-architecture/vpe.svg)
