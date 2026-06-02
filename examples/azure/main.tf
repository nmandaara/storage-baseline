provider "azurerm" {
  features {}
}

module "analytics_storage" {
  source = "../../azure/modules/storage"

  # Required
  resource_group_name  = "rg-DevTest-001"
  storage_account_name = "stdataanalytics001"

  # Override defaults for analytics workload
  account_replication_type = "LRS"
  versioning_enabled       = true
  delete_retention_days    = 14

  # Only allow access from data team network
  network_rules_ip_rules = ["10.10.10.0/24"] # Replace with actual IP range of data team network

  extra_tags = {
    environment = "production"
    team        = "data-analytics"
    cost-center = "engineering"
  }
}