data "aws_region" "current" {}

resource "random_string" "rand" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_kms_key" "kms_key" {}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "s3-remote-state-storage-${random_string.rand.result}"
  versioning {
    enabled = true
  }
  lifecycle {
      prevent_destroy = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
        kms_master_key_id = aws_kms_key.kms_key.arn
      }
    }
  }
}

resource "aws_dynamodb_table" "dynamodb_table" {
  name = "s3-remote-state-lock"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}