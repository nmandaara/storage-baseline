data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}
resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  access_tier              = var.access_tier
  https_traffic_only_enabled = var.https_traffic_only_enabled
  min_tls_version          = var.min_tls_version

  network_rules {
    default_action             = var.network_rules_default_action
    ip_rules                   = var.network_rules_ip_rules
  }

  blob_properties {
    versioning_enabled = var.versioning_enabled

    delete_retention_policy {
      days = var.delete_retention_days
    }
  }

  tags = merge(
    var.extra_tags,
    data.azurerm_resource_group.rg.tags
  )
}

resource "azurerm_storage_management_policy" "storage_management_policy" {
  storage_account_id = azurerm_storage_account.storage_account.id

  rule {
    name    = "tiering-rules"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than = var.cool_after_days
        tier_to_archive_after_days_since_modification_greater_than = var.archive_after_days
      }
    }
  }
}