variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account to create."
}

variable "account_tier" {
  type        = string
  description = "Defines the performance tier of the storage account. Valid values are 'Standard' and 'Premium'."
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "The account_tier variable must be either 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  type        = string
  description = "Defines the replication strategy for the storage account. Valid values are 'LRS', 'GRS', 'RAGRS', and 'ZRS'."
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS"], var.account_replication_type)
    error_message = "The account_replication_type variable must be one of 'LRS', 'GRS', 'RAGRS', or 'ZRS'."
  }
}

variable "access_tier" {
  type        = string
  description = "Defines the access tier for the storage account. Valid values are 'Hot' and 'Cool'."
  default     = "Hot"
}

variable "https_traffic_only_enabled" {
  type        = bool
  description = "Indicates whether HTTPS traffic only is enabled for the storage account."
  default     = true
}

variable "min_tls_version" {
  type        = string
  description = "Defines the minimum TLS version to be permitted on requests to storage. Valid values are 'TLS1_2' and 'TLS1_3'."
  default     = "TLS1_2"

  validation {
    condition     = contains(["TLS1_2", "TLS1_3"], var.min_tls_version)
    error_message = "The min_tls_version variable must be one of 'TLS1_2', or 'TLS1_3'."
  }
}

variable "network_rules_default_action" {
  type        = string
  description = "Defines the default action for network rules. Valid values are 'Allow' and 'Deny'."
  default     = "Deny"

  validation {
    condition     = contains(["Allow", "Deny"], var.network_rules_default_action)
    error_message = "The network_rules_default_action variable must be either 'Allow' or 'Deny'."
  }
}

variable "network_rules_ip_rules" {
  type        = list(string)
  description = "A list of IP addresses or CIDR blocks to allow or deny based on the network rules default action."
  default     = []
}

variable "versioning_enabled" {
  type        = bool
  description = "Indicates whether blob versioning is enabled for the storage account."
  default     = false
}

variable "delete_retention_days" {
  type        = number
  description = "The number of days that soft-deleted blobs should be retained before permanent deletion. Valid values are between 1 and 365."
  default     = 7

  validation {
    condition     = var.delete_retention_days >= 1 && var.delete_retention_days <= 365
    error_message = "The delete_retention_days variable must be between 1 and 365."
  }
}

variable "extra_tags" {
  type        = map(string)
  description = "A map of additional tags to assign to the storage account. These will be merged with the resource group's tags."
  default     = {}
}

variable "cool_after_days" {
  type        = number
  description = "The number of days after which to tier base blobs to cool storage. Must be less than archive_after_days. Minimum 30."
  default     = 30

  validation {
    condition     = var.cool_after_days >= 30
    error_message = "cool_after_days must be at least 30 days."
  }
}

variable "archive_after_days" {
  type        = number
  description = "The number of days after which to tier base blobs to archive storage. Must be greater than cool_after_days. Minimum 90."
  default     = 90

  validation {
    condition     = var.archive_after_days >= 90
    error_message = "archive_after_days must be at least 90 days."
  }
}
