output "storage_account_name" {
  value       = azurerm_storage_account.site.name
  description = "The Azure Storage Account Name"
}

output "storage_account_url" {
  value       = azurerm_storage_account.site.primary_web_endpoint
  description = "The Azure Storage Account URL"
}
