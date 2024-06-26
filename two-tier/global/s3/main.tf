provider "aws" {
    region = "eu-central-1"
}
resource  "aws_s3_bucket" "terraform_state" {
    bucket = "proj2-vpc2tier-tfstate"
    #Prevent accidental deletion of this S3 bucket
    lifecycle {
        prevent_destroy = true
    }
}
resource "aws_s3_bucket_versioning" "enabled" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
        status = "Enabled"
    }
}
#turn server-side encryption on by default for all data written to
#this S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket =aws_s3_bucket.terraform_state.id
  rule {
    apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
    }
  }
}
#block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket =aws_s3_bucket.terraform_state.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}
#Configure dynamodb table for locking file
resource "aws_dynamodb_table" "terraform_locks"{
    name = "proj2-vpc2tier-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}