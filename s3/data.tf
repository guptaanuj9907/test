data "aws_s3_bucket" "rzp-aws-logs" {
  bucket = "rzp-aws-logs"
}

data "aws_s3_bucket" "s3accesslogsrzp-us-east-1" {
  provider = "aws.us"
  bucket   = "s3accesslogsrzp-us-east-1"
}

data "aws_kms_key" "rzp-1415-prod-amazonpay" {
  key_id = "alias/rzp-1415-prod-amazonpay"
}

data "aws_s3_bucket" "prod-us-h2h" {
  provider = "aws.us"
  bucket   = "prod-us-h2h"
}