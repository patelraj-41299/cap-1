# Create S3 Bucket for CodePipeline Artifacts
resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "cap-1-codepipeline-artifacts-${random_id.bucket_suffix.hex}"

  force_destroy = true

  tags = {
    Name = "cap-1-pipeline-bucket"
  }
}

# Add random suffix to bucket name (S3 bucket names must be globally unique)
resource "random_id" "bucket_suffix" {
  byte_length = 4
}
