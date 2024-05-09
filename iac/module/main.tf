data "azurerm_resource_group" "deploy" {
  name = var.target_resource_group
}

locals {
  sitename       = format("%s%s%ssweb", var.prefix, var.cloudid, var.environment) 
  aad_group_name = format("%s Project Users", var.cohortid)                      

}
resource "azurerm_storage_account" "site" {
  name                     = local.sitename
  resource_group_name      = data.azurerm_resource_group.deploy.name
  location                 = data.azurerm_resource_group.deploy.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = {
    cohort      = var.cohortid
    pod         = var.pod
    user        = var.cloudid
    environment = var.environment
    usage       = "web"
  }
}

data "azuread_group" "target_group" {
  display_name = local.aad_group_name
}

resource "azurerm_role_assignment" "blob_data_owner" {
  count                = var.user_write_access == "sbx" ? 1 : 0
  scope                = azurerm_storage_account.site.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azuread_group.target_group.object_id
}

resource "azurerm_role_assignment" "account_key_operator" {
  count                = var.user_write_access == "sbx" ? 1 : 0
  scope                = azurerm_storage_account.site.id
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = data.azuread_group.target_group.object_id
}