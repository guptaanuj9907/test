terraform {
  required_version = "0.11.11"

  backend "s3" {
    bucket  = "rzp-ops-bucket"
    key     = "vishnu/ap-south-1/prod/iam/ops/terraform.tfstate"
    region  = "ap-south-1"
  }
}

provider "aws" {
  region  = "ap-south-1"
  version = "v2.60.0"
}
