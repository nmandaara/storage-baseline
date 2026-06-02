provider "aws" {
  region = "us-east-1"
}

module "analytics_storage" {
  region = "us-east-1"
  source = "../../aws/modules/storage"

  # Required
  bucket_name = "data-analytics-001"

  # Override defaults for analytics workload
  versioning = true

  # Only allow access from data team network
  extra_tags = {
    environment = "production"
    team        = "data-analytics"
    cost-center = "engineering"
  }
}

output "bucket_id" {
  value = module.analytics_storage.bucket_id
}

output "bucket_arn" {
  value = module.analytics_storage.bucket_arn
}