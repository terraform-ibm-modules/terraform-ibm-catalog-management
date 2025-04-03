module "vpe_object" {
  source                       = "../../modules/vpe-catalog-object"
  catalog_id                   = var.catalog_id
  name                         = var.name
  label                        = var.label
  endpoint_type                = var.endpoint_type
  dns_domain                   = var.dns_domain
  fully_qualified_domain_names = var.fully_qualified_domain_names
  service_crn                  = var.service_crn
  region                       = var.region
  tags                         = var.tags
  short_description            = var.short_description
}
