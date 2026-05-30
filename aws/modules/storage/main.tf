resource "aws_s3_bucket" "storage_bucket" {

  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = var.extra_tags
}

# Block public access
resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.storage_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enforce HTTPS only access
resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  bucket = aws_s3_bucket.storage_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }

    # Explicitly block SSE-C — AWS is enforcing this on new buckets from April 2026
    bucket_key_enabled       = true
    blocked_encryption_types = ["SSE-C"]
  }
}

#Lifecycle rule to transition objects to Glacier and Deep Archive
resource "aws_s3_bucket_lifecycle_configuration" "bucket_lifecycle" {
  bucket = aws_s3_bucket.storage_bucket.id

  rule {
    id     = "TransitionToGlacierAndDeepArchive"
    status = "Enabled"

    transition {
      days          = var.cool_after_days
      storage_class = "GLACIER"
    }

    transition {
      days          = var.archive_after_days
      storage_class = "DEEP_ARCHIVE"
    }
  }
}