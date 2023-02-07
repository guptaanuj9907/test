variable "name" {
  default = "razorpay"
}

variable "environment" {
  default = "prod"
}

variable "account_id" {
  default = "141592612890"
}

variable "rzpx_account_id" {
  default = "074624632167"
}

variable "region" {
  default = "ap-south-1"
}

variable "sumo-account-id" {
  description = "The account id of the account in which the resources are being created"
  default     = "926226587429"
}

variable "bvs_service_accounts" {
  default = [
    "system:serviceaccount:bvs:bvs"
  ]
}
