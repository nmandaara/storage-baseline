output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_endpoint" {
  description = "The primary endpoint of the storage account."
  value       = azurerm_storage_account.storage_account.primary_blob_endpoint
}