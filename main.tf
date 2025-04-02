resource "ibm_cm_catalog" "cm_catalog" {
  label              = var.label
  short_description  = var.short_description
  catalog_icon_url   = var.catalog_icon_url
  kind               = var.kind
  tags               = var.tags
  catalog_banner_url = var.catalog_banner_url
  disabled           = var.disabled
  resource_group_id  = var.resource_group_id

  dynamic "target_account_contexts" {
    for_each = var.target_accounts
    content {
      api_key    = target_account_contexts.value["api_key"]
      name       = target_account_contexts.value["name"]
      label      = target_account_contexts.value["label"]
      project_id = target_account_contexts.value["project_id"]
      trusted_profile {
        trusted_profile_id = target_account_contexts.value["trusted_profile_id"]
        target_service_id  = target_account_contexts.value["target_service_id"]
      }
    }
  }
}
