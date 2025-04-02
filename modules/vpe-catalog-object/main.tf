resource "ibm_cm_object" "cm_object" {
  catalog_id        = var.catalog_id
  name              = var.name
  label             = var.label
  kind              = "vpe"
  short_description = var.short_description
  data = jsonencode({
    endpoint_type                = var.endpoint_type,
    dns_domain                   = var.dns_domain,
    fully_qualified_domain_names = var.fully_qualified_domain_names
    service_crn                  = var.service_crn
  })
  parent_id = var.region
  tags      = var.tags
}
