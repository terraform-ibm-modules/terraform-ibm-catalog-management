########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.7"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# Project
########################################################################################################################

resource "ibm_project" "project_instance" {
  definition {
    name               = "${var.prefix}-project"
    description        = "Sample project"
    destroy_on_delete  = true
    monitoring_enabled = true
    auto_deploy        = true
  }
  location       = var.region
  resource_group = module.resource_group.resource_group_name
}

########################################################################################################################
# Catalog
########################################################################################################################

module "catalog" {
  source = "git::https://github.com/terraform-ibm-modules/terraform-ibm-catalog-management?ref=main"
  # remove the above line and uncomment the below 2 lines to consume the module from the registry
  # source            = "terraform-ibm-modules/catalog-management/ibm"
  # version           = "X.Y.Z" # Replace "X.Y.Z" with a release version to lock into a specific release
  label             = "${var.prefix}-catalog"
  short_description = "Created by example code"
  resource_group_id = module.resource_group.resource_group_id
  kind              = "offering"
  tags              = var.resource_tags
  # NOTE: target accounts can only be configured on an update, not on a create, so it will take 2 applies to get this config complete.
  target_accounts = [
    # example of adding target account using apikey
    {
      name    = "${var.prefix}-apikey"
      label   = "apikey"
      api_key = var.ibmcloud_api_key
    },
    # example of adding target account using project and apikey
    {
      name       = "${var.prefix}-prj-apikey"
      label      = "project and apikey"
      project_id = ibm_project.project_instance.id
      api_key    = var.ibmcloud_api_key
    }
  ]
}
