########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.8"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# Catalog
########################################################################################################################

module "catalog" {
  source = "../.."
  # remove the above line and uncomment the below 2 lines to consume the module from the registry
  # source            = "terraform-ibm-modules/catalog-management/ibm"
  # version           = "X.Y.Z" # Replace "X.Y.Z" with a release version to lock into a specific release
  label             = "${var.prefix}-catalog"
  short_description = "Created by example code"
  resource_group_id = module.resource_group.resource_group_id
  kind              = "vpe"
  tags              = var.tags
}

########################################################################################################################
# VPE Catalog object
########################################################################################################################

module "vpe_object" {
  source = "../../modules/vpe-catalog-object"
  # remove the above line and uncomment the below 2 lines to consume the module from the registry
  # source            = "terraform-ibm-modules/catalog-management/ibm//modules/vpe-catalog-object"
  # version           = "X.Y.Z" # Replace "X.Y.Z" with a release version to lock into a specific release
  catalog_id                   = module.catalog.id
  name                         = "${var.prefix}_vpe_object" # Tip: cannot use dashes in name
  label                        = "VPE Object (${var.prefix})"
  endpoint_type                = "api"
  dns_domain                   = "example.com"
  fully_qualified_domain_names = ["vpe-catalog-object-fqdn.example.com", "vpe-catalog-object-fqdn-v2.example.com"]
  service_crn                  = "crn:v1:bluemix:public:service:global:::endpoint:test.private.example.com"
  region                       = var.region
}
