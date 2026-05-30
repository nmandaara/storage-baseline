variable "bucket_name" {
  description = "Name of the S3 bucket to be created"
  type        = string
}

variable "region" {
  description = "AWS region where the S3 bucket will be created"
  type        = string
}

variable "versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = false
}

variable "cool_after_days" {
  description = "Number of days after which objects will be transitioned to Glacier"
  type        = number
  default     = 30
}

variable "archive_after_days" {
  description = "Number of days after which objects will be transitioned to Deep Archive"
  type        = number
  default     = 90
}

variable "force_destroy" {
  description = "Whether to force destroy the bucket even if it contains objects"
  type        = bool
  default     = false
}

variable "extra_tags" {
  description = "Additional tags to apply to the S3 bucket"
  type        = map(string)
  default     = {}
}
