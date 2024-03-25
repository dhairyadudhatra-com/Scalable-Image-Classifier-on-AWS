# Define the S3 buckets
# variable "input_bucket_name" {}
# variable "output_bucket_name" {}

resource "aws_s3_bucket" "input_bucket" {
  bucket = var.input_bucket_name
}
resource "aws_s3_bucket" "output_bucket" {
  bucket = var.output_bucket_name
}
