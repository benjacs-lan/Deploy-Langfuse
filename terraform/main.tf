resource "aws_s3_bucket" "langsfuse-bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "langsfuse-storage-ownership" {
  bucket = aws_s3_bucket.langsfuse-bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}


