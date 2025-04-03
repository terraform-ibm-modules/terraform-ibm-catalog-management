########################################################################################################################
# Resource group
########################################################################################################################

module "resource_group" {
  source                       = "terraform-ibm-modules/resource-group/ibm"
  version                      = "1.1.6"
  existing_resource_group_name = var.existing_resource_group_name
}

########################################################################################################################
# Catalog
########################################################################################################################

module "catalog" {
  source             = "../.."
  label              = var.label
  short_description  = var.short_description
  resource_group_id  = module.resource_group.resource_group_id
  kind               = var.kind
  tags               = var.tags
  catalog_banner_url = var.catalog_banner_url
  disabled           = var.disabled
  catalog_icon_url   = var.catalog_icon_url
}
