resource "aws_s3_bucket" "prod-ufh-reports" {
  bucket = "prod-ufh-reports"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.prod-ufh-reports.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/prod-ufh-reports/"
  }

  lifecycle_rule {
    id = "logs_data_clean_up"
    enabled = true
    prefix  = "logs/"

    expiration {
      days = 90
    }

    noncurrent_version_expiration {
      days = 90
    }
  }

  tags {
    Name                     = "prod-ufh-reports"
    terraform                = "true"
    data_policy_label        = "client_data"
    environment              = "production"
    team                     = "post-payments"
    bu                       = "payments"
    "org.rzp.business-unit"  = "payments"
    "org.rzp.environment"    = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "prod-ufh-reports" {
  bucket = "${aws_s3_bucket.prod-ufh-reports.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-ops-prod-backup" {
  bucket = "rzp-ops-prod-backup"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-ops-prod-backup.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-ops-prod-backup/"
  }

  tags {
    Name                      = "rzp-ops-prod-backup"
    data_policy_label         = "private_data"
    terraform                 = "true"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-ops-prod-backup" {
  bucket = "${aws_s3_bucket.rzp-ops-prod-backup.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-aws-prodelb-logs" {
  bucket = "rzp-aws-prodelb-logs"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.s3-prod-aws-logs.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-aws-prodelb-logs/"
  }

  tags {
    Name                      = "rzp-aws-prodelb-logs"
    terraform                 = "true"
    data_policy_label         = "company_data"
    environment               = "Production"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_notification" "rzp-recon-file-fetch-bucket-notification" {
  bucket = "${data.aws_s3_bucket.prod-us-h2h.id}"
  provider = "aws.us"

  topic {
    topic_arn     = "arn:aws:sns:us-east-1:141592612890:prod-recon-file-fetch"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "icici/incoming/000205029522_"
  }
  topic {
    topic_arn     = "arn:aws:sns:us-east-1:141592612890:prod-recon-file-fetch"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "yesbank/e_statements/YBL"
    filter_suffix = ".CSV"
  }

  topic {
    topic_arn     = "arn:aws:sns:us-east-1:141592612890:prod-recon-file-fetch"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "icici/incoming_imps/Batch"
    filter_suffix = "46751"
  }

  topic {
    topic_arn     = "arn:aws:sns:us-east-1:141592612890:prod-recon-file-fetch"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "icici/incoming_imps/Batch"
    filter_suffix = "29522"
  }
  topic {
    topic_arn     = "arn:aws:sns:us-east-1:141592612890:prod-recon-file-fetch"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "icici/incoming/000705046751_"
  }

  lambda_function {
    lambda_function_arn     = "arn:aws:lambda:us-east-1:141592612890:function:poweraccess_axis_h2h_notify"
    events                  = ["s3:ObjectCreated:Put"]
    filter_prefix           = "axis/poweraccess/incoming/axis_reversefeed_razorpay_20"
  }

   lambda_function {
    lambda_function_arn     = "arn:aws:lambda:us-east-1:141592612890:function:rbl-enach-debit-h2h-notify"
    events                  = ["s3:ObjectCreated:Put"]
    filter_prefix           = "rbl-enach/incoming/TXN_RES/"
  }

  lambda_function {
    lambda_function_arn     = "arn:aws:lambda:us-east-1:141592612890:function:poweraccess_axis_h2h_error_notify"
    events                  = ["s3:ObjectCreated:Put"]
    filter_prefix           = "axis/poweraccess/error/error_"
  }

  lambda_function {
    lambda_function_arn     = "arn:aws:lambda:us-east-1:141592612890:function:enach_npci_nb_debit"
    events                  = ["s3:ObjectCreated:Put"]
    filter_prefix           = "yesbank/nach/response"
  }

  lambda_function {
    lambda_function_arn     = "arn:aws:lambda:us-east-1:141592612890:function:rbl-enach-ack-h2h-notify"
    events                  = ["s3:ObjectCreated:Put"]
    filter_prefix           = "rbl-enach/incoming/MNDT_ACK/"
  }
  lambda_function {
    lambda_function_arn     = "arn:aws:lambda:us-east-1:141592612890:function:poweraccess_axis_h2h_error_notify"
    events                  = ["s3:ObjectCreated:Put"]
    filter_prefix           = "axis/poweraccess/error/*.txt"
  }
  lambda_function {
    lambda_function_arn     = "arn:aws:lambda:us-east-1:141592612890:function:icici_nb_recon_notify"
    events                  = ["s3:ObjectCreated:Put"]
    filter_prefix           = "icici/recon/NetbankingIcici/"
  }

  lambda_function {
    lambda_function_arn     = "arn:aws:lambda:us-east-1:141592612890:function:rbl-enach-res-h2h-notify"
    events                  = ["s3:ObjectCreated:Put"]
    filter_prefix           = "rbl-enach/incoming/MNDT_RES/"
  }

}

resource "aws_s3_bucket_notification" "rzp-aws-prodelb-logs-notification" {
  bucket = "${aws_s3_bucket.rzp-aws-prodelb-logs.id}"

  queue {
    queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:prod-fluent-cloudtrail"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "rzp-cloudtrail/AWSLogs/o-l380vrxrxm/141592612890/CloudTrail"
  }

  # queue {
  #   queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:cde-blue-fluent-elb"
  #   events        = ["s3:ObjectCreated:*"]
  #   filter_prefix = "prod-blue-external/"
  # }

  # queue {
  #   queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:cde-blue-fluent-elb"
  #   events        = ["s3:ObjectCreated:*"]
  #   filter_prefix = "cde-blue-concierge/"
  # }

  # queue {
  #   queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:cde-blue-fluent-elb"
  #   events        = ["s3:ObjectCreated:*"]
  #   filter_prefix = "cde-blue-internal/"
  # }

  # queue {
  #   queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:cde-green-fluent-elb"
  #   events        = ["s3:ObjectCreated:*"]
  #   filter_prefix = "cde-green-external/"
  # }

  # queue {
  #   queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:cde-green-fluent-elb"
  #   events        = ["s3:ObjectCreated:*"]
  #   filter_prefix = "cde-green-concierge/"
  # }

  # queue {
  #   queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:cde-green-fluent-elb"
  #   events        = ["s3:ObjectCreated:*"]
  #   filter_prefix = "cde-green-internal/"
  #}

  # queue {
  #   queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:prod-green-fluent-elb"
  #   events        = ["s3:ObjectCreated:*"]
  #   filter_prefix = "prod-green-external/"
  # }

  # queue {
  #   queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:prod-green-fluent-elb"
  #   events        = ["s3:ObjectCreated:*"]
  #   filter_prefix = "prod-green-concierge/"
  # }

  # queue {
  #   queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:prod-green-fluent-elb"
  #   events        = ["s3:ObjectCreated:*"]
  #   filter_prefix = "prod-green-internal/"
  # }

  queue {
    queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:prod-blue-fluent-elb"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "prod-blue-external/"
  }

  queue {
    queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:prod-blue-fluent-elb"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "prod-blue-concierge/"
  }

  queue {
    queue_arn     = "arn:aws:sqs:ap-south-1:141592612890:prod-blue-fluent-elb"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "prod-blue-internal/"
  }


  topic {
    topic_arn     = "arn:aws:sns:ap-south-1:141592612890:SumoSNSTopic-SumoSNSTopic-waf"
    events        = ["s3:ObjectCreated:*"]
    filter_prefix = "waf-logs/"
  }

}

resource "aws_s3_bucket_public_access_block" "rzp-aws-prodelb-logs" {
  bucket = "${aws_s3_bucket.rzp-aws-prodelb-logs.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-archive-s3-migration" {
  bucket = "rzp-archive-s3-migration"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-archive-s3-migration.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-archive-s3-migration/"
  }

  tags {
    Name                      = "rzp-archive-s3-migration"
    terraform                 = "true"
    data_policy_label         = "company_data"
    environment               = "archival"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-archive-s3-migration" {
  bucket = "${aws_s3_bucket.rzp-archive-s3-migration.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-sumologic-logstore" {
  bucket = "rzp-sumologic-logstore"
  acl    = "private"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-sumologic-logstore/"
  }

  tags {
    Name                      = "rzp-sumologic-logstore"
    terraform                 = "true"
    data_policy_label         = "company_data"
    environment               = "Production"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  lifecycle_rule {
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-sumologic-logstore" {
  bucket = "${aws_s3_bucket.rzp-sumologic-logstore.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-ufh-admin" {
  bucket = "rzp-prod-ufh-admin"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-ufh-admin.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-ufh-admin/"
  }

  tags {
    name                      = "rzp-prod-ufh-admin"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    team                      = "post-payments"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-ufh-admin" {
  bucket = "${aws_s3_bucket.rzp-prod-ufh-admin.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-api-settlements" {
  bucket = "rzp-prod-api-settlements"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-api-settlements.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-api-settlements/"
  }

  tags {
    Name                      = "rzp-prod-api-settlements"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "production"
    team                      = "settlements"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-api-settlements" {
  bucket = "${aws_s3_bucket.rzp-prod-api-settlements.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-beam-cde" {
  bucket = "rzp-prod-beam-cde"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-beam-cde.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-beam-cde/"
  }

  lifecycle_rule {
    id      = "Delete carddata files after 7 days"
    enabled = true
    prefix  = "sbi_emi/"

    expiration {
      days = 1
    }
  }

  tags {
    Name                      = "rzp-prod-beam-cde"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "production"
    team                      = "post-payments"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"

  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-beam-cde" {
  bucket = "${aws_s3_bucket.rzp-prod-beam-cde.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-beam-non-cde" {
  bucket = "rzp-prod-beam-non-cde"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-beam-non-cde.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-beam-non-cde/"
  }

  tags {
    Name                      = "rzp-prod-beam-non-cde"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "production"
    team                      = "post-payments"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-beam-non-cde" {
  bucket = "${aws_s3_bucket.rzp-prod-beam-non-cde.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-scrooge" {
  bucket = "rzp-prod-scrooge"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-scrooge.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-scrooge/"
  }

  tags {
    name                      = "rzp-prod-scrooge"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "Production"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-scrooge" {
  bucket = "${aws_s3_bucket.rzp-prod-scrooge.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-batch" {
  bucket = "rzp-prod-batch"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-batch.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-batch/"
  }

  tags {
    Name                      = "rzp-prod-batch"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "production"
    bu                        = "platform"
    "org.rzp.business-unit"   = "platform"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-batch" {
  bucket = "${aws_s3_bucket.rzp-prod-batch.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-email-templates" {
  bucket = "rzp-prod-email-templates"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-email-templates.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-email-templates/"
  }

  tags {
    name                      = "rzp-prod-email-templates"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "all"
    "org.rzp.business-unit"   = "shared"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-email-templates" {
  bucket = "${aws_s3_bucket.rzp-prod-email-templates.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-paper-mandates" {
  bucket = "rzp-prod-paper-mandates"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-paper-mandates.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-paper-mandates/"
  }

  tags {
    name                      = "rzp-prod-paper-mandates"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-paper-mandates" {
  bucket = "${aws_s3_bucket.rzp-prod-paper-mandates.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-npm-registry" {
  bucket = "rzp-prod-npm-registry"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-npm-registry.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-npm-registry/"
  }

  tags {
    name                      = "rzp-prod-npm-registry"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "all"
    "org.rzp.business-unit"   = "shared"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-npm-registry" {
  bucket = "${aws_s3_bucket.rzp-prod-npm-registry.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-doppler-config" {
  bucket = "rzp-prod-doppler-config"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-doppler-config.json}"

  versioning {
    enabled = false
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-doppler-config/"
  }

  tags {
    name                      = "rzp-prod-doppler-config"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "dataengineering"
    "org.rzp.business-unit"   = "dataengineering"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-doppler-config" {
  bucket = "${aws_s3_bucket.rzp-prod-doppler-config.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-bitrise-frontend-commander-platoon" {
  bucket = "rzp-1415-prod-bitrise-frontend-commander-platoon"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-bitrise-frontend-commander-platoon.json}"

  logging {
    target_bucket = "rzp-aws-logs"
    target_prefix = "s3/prod/rzp-1415-prod-bitrise-frontend-commander-platoon/"
  }

  versioning {
    enabled = true
  }

  tags {
    name                      = "rzp-1415-prod-bitrise-frontend-commander-platoon"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    team                      = "frontend"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-bitrise-frontend-commander-platoon" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-bitrise-frontend-commander-platoon.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-thanos" {
  bucket = "rzp-prod-thanos"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-thanos.json}"

  versioning {
    enabled = false
  }

  logging {
    target_bucket = "rzp-aws-logs"
    target_prefix = "s3/prod/rzp-prod-thanos/"
  }

  lifecycle_rule {
    id      = "30 days rotation"
    enabled = true

    expiration {
      days = "30"
    }
  }

  tags {
    Name                      = "rzp-prod-thanos"
    terraform                 = "true"
    data_policy_label         = "company_data"
    environment               = "production"
    role                      = "monitoring"
    team                      = "devops"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-thanos" {
  bucket = "${aws_s3_bucket.rzp-prod-thanos.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-rds-snapshot-coordinates" {
  bucket = "rzp-prod-rds-snapshot-coordinates"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-rds-snapshot-coordinates.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-rds-snapshot-coordinates/"
  }

  tags {
    name                      = "rzp-prod-rds-snapshot-coordinates"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-rds-snapshot-coordinates" {
  bucket = "${aws_s3_bucket.rzp-prod-rds-snapshot-coordinates.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-vendor-payments-invoices" {
  bucket = "rzp-prod-vendor-payments-invoices"
  acl    = "private"
  region = "ap-south-1"
  policy = "${data.aws_iam_policy_document.rzp-prod-vendor-payments-invoices.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-vendor-payments-invoices/"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://x.razorpay.com"]
    max_age_seconds = 3000
  }

  tags {
    name                      = "rzp-prod-vendor-payments-invoices"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-vendor-payments-invoices" {
  bucket = "${aws_s3_bucket.rzp-prod-vendor-payments-invoices.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "badges-razorpay-com" {
  bucket = "badges.razorpay.com"
  acl    = "private"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-badges-razorpay-com/"
  }

  website {
    index_document = "index.html"
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  tags {
    Name                      = "badges.razorpay.com"
    terraform                 = "true"
    Environment               = "prod"
    bu                        = "platform"
    data_policy_label         = "public_data"
    "org.rzp.business-unit"   = "platform"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "vpc-flow-log" {
  bucket = "rzp-prod-vpc-flow-logs"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-vpc-flow-logs.json}"


  logging {
    target_bucket = "rzp-ops-logs-audit"
    target_prefix = "prod-vpc/"
  }

  tags {
    Name                      = "rzp-prod-vpc-flow-logs"
    terraform                 = "true"
    Environment               = "prod"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "arn:aws:kms:ap-south-1:141592612890:key/ac2068e4-d6f0-4934-8325-eaabbe701870"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-kube-manifests" {
  bucket = "rzp-kube-manifests"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-kube-manifests.json}"

  versioning {
    enabled = false
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-kube-manifests/"
  }

  lifecycle_rule {
    id      = "30 days rotation"
    enabled = true

    expiration {
      days = "30"
    }
  }

  tags {
    Name                      = "rzp-kube-manifests"
    terraform                 = "true"
    environment               = "production"
    bu                        = "devops"
    data_policy_label         = "private_data"
    team                      = "devops"
    role                      = "kube-manifest"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "vpc-flow-log" {
  bucket = "rzp-prod-vpc-flow-logs"

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

resource "aws_s3_bucket_public_access_block" "rzp-kube-manifests" {
  bucket = "${aws_s3_bucket.rzp-kube-manifests.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-financial-data-service" {
  bucket = "rzp-prod-financial-data-service"
  acl    = "private"
  region = "ap-south-1"
  policy = "${data.aws_iam_policy_document.rzp-prod-financial-data-service.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${aws_s3_bucket.rzp-prod-object-logging-bucket.id}"
    target_prefix = "fds/log/"
  }

  tags {
    name                      = "rzp-prod-financial-data-service"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "capital"
    "org.rzp.business-unit"   = "capital"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-financial-data-service" {
  bucket = "${aws_s3_bucket.rzp-prod-financial-data-service.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-object-logging-bucket" {
  bucket = "rzp-prod-object-logging-bucket"
  acl    = "log-delivery-write"
  policy = "${data.aws_iam_policy_document.rzp-prod-object-logging-bucket.json}"

  versioning {
    enabled = false
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-object-logging-bucket/"
  }

  tags {
    name                      = "rzp-prod-object-logging-bucket"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "all"
    "org.rzp.business-unit"   = "shared"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-object-logging-bucket" {
  bucket = "${aws_s3_bucket.rzp-prod-object-logging-bucket.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-splitz" {
  bucket = "rzp-prod-splitz"
  acl    = "private"
  region = "ap-south-1"
  policy = "${data.aws_iam_policy_document.rzp-prod-splitz.json}"

  versioning {
    enabled = false
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-splitz/"
  }

  tags {
    name                      = "rzp-prod-splitz"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "platform"
    "org.rzp.business-unit"   = "platform"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-splitz" {
  bucket = "${aws_s3_bucket.rzp-prod-splitz.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-facebook" {
  bucket = "rzp-1415-prod-facebook"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-facebook.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-facebook/"
  }

  versioning {
    enabled = true
  }

  tags {
    name                      = "rzp-1415-prod-facebook"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    team                      = "apps"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-facebook" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-facebook.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-harbor-registry" {
  bucket = "rzp-prod-harbor-registry"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-harbor-registry.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-harbor-registry/test/"
  }

  tags {
    name                      = "rzp-prod-harbor-registry"
    terraform                 = "true"
    bu                        = "all"
    data_policy_label         = "private_data"
    environment               = "Production"
    "org.rzp.business-unit"   = "shared"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-harbor-registry" {
  bucket = "${aws_s3_bucket.rzp-prod-harbor-registry.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

# Opfin Private buckets

resource "aws_s3_bucket" "xpayroll-1415-form16s" {
  bucket = "xpayroll-1415-form16s"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-form16s/"
  }

  tags {
    name                      = "xpayroll-1415-form16s"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-form16s" {
  bucket = "${aws_s3_bucket.xpayroll-1415-form16s.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-contractors-invoices" {
  bucket = "xpayroll-1415-contractors-invoices"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-contractors-invoices/"
  }

  tags {
    name                      = "xpayroll-1415-contractors-invoices"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-contractors-invoices" {
  bucket = "${aws_s3_bucket.xpayroll-1415-contractors-invoices.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-documents" {
  bucket = "xpayroll-1415-documents"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-documents/"
  }

  tags {
    name                      = "xpayroll-1415-documents"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-documents" {
  bucket = "${aws_s3_bucket.xpayroll-1415-documents.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-employee-photos" {
  bucket = "xpayroll-1415-employee-photos"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-employee-photos/"
  }

  tags {
    name                      = "xpayroll-1415-employee-photos"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-employee-photos" {
  bucket = "${aws_s3_bucket.xpayroll-1415-employee-photos.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-kyc" {
  bucket = "xpayroll-1415-kyc"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-kyc/"
  }

  tags {
    name                      = "xpayroll-1415-kyc"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-kyc" {
  bucket = "${aws_s3_bucket.xpayroll-1415-kyc.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-tax-deduction-documents" {
  bucket = "xpayroll-1415-tax-deduction-documents"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-tax-deduction-documents/"
  }

  tags {
    name                      = "xpayroll-1415-tax-deduction-documents"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-tax-deduction-documents" {
  bucket = "${aws_s3_bucket.xpayroll-1415-tax-deduction-documents.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-tds" {
  bucket = "xpayroll-1415-tds"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-tds/"
  }

  tags {
    name                      = "xpayroll-1415-tds"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-tds" {
  bucket = "${aws_s3_bucket.xpayroll-1415-tds.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-tds-acks" {
  bucket = "xpayroll-1415-tds-acks"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-tds-acks/"
  }

  tags {
    name                      = "xpayroll-1415-tds-acks"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-tds-acks" {
  bucket = "${aws_s3_bucket.xpayroll-1415-tds-acks.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-transaction-documents" {
  bucket = "xpayroll-1415-transaction-documents"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-transaction-documents/"
  }

  tags {
    name                      = "xpayroll-1415-transaction-documents"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-transaction-documents" {
  bucket = "${aws_s3_bucket.xpayroll-1415-transaction-documents.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-reimbursements" {
  bucket = "xpayroll-1415-reimbursements"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-reimbursements/"
  }

  tags {
    name                      = "xpayroll-1415-reimbursements"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-reimbursements" {
  bucket = "${aws_s3_bucket.xpayroll-1415-reimbursements.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "xpayroll-1415-automation" {
  bucket = "xpayroll-1415-automation"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-automation/"
  }

  tags {
    name                      = "xpayroll-1415-automation"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "xpayroll-1415-automation" {
  bucket = "${aws_s3_bucket.xpayroll-1415-automation.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

# Opfin Public bucket for logos

resource "aws_s3_bucket" "xpayroll-1415-org-logos" {
  bucket = "xpayroll-1415-org-logos"
  acl    = "public-read"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/xpayroll-1415-org-logos/"
  }

  tags {
    name                      = "xpayroll-1415-org-logos"
    terraform                 = "true"
    data_policy_label         = "public"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-tidb-backup" {
  bucket = "rzp-1415-tidb-backup"
  acl    = "private"
  region = "ap-south-1"
  policy = "${data.aws_iam_policy_document.rzp-1415-tidb-backup.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-tidb-backup/"
  }

  tags {
    name                      = "rzp-1415-tidb-backup"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "all"
    "org.rzp.business-unit"   = "shared"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  lifecycle_rule {
    enabled = true
    expiration {
      days = 7
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-tidb-backup" {
  bucket = "${aws_s3_bucket.rzp-1415-tidb-backup.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-tidb-reporting-backup" {
  bucket = "rzp-1415-tidb-reporting-backup"
  acl    = "private"
  region = "ap-south-1"
  policy = "${data.aws_iam_policy_document.rzp-1415-tidb-reporting-backup.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-tidb-reporting-backup/"
  }

  tags {
    name                      = "rzp-1415-tidb-reporting-backup"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "all"
    "org.rzp.business-unit"   = "shared"
    "org.rzp.environment"     = "production"
  }

  lifecycle_rule {
    id      = "Delete backup files after 7 days"
    enabled = true

    expiration {
      days = 7
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-tidb-reporting-backup" {
  bucket = "${aws_s3_bucket.rzp-1415-tidb-reporting-backup.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-neo4j" {
  bucket = "rzp-prod-neo4j"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-neo4j.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-neo4j/"
  }

  tags {
    name                      = "rzp-prod-neo4j"
    terraform                 = "true"
    bu                        = "dataengineering"
    data_policy_label         = "private_data"
    environment               = "Production"
    "org.rzp.business-unit"   = "dataengineering"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-neo4j/"
  }

}

resource "aws_s3_bucket_public_access_block" "rzp-prod-neo4j" {
  bucket = "${aws_s3_bucket.rzp-prod-neo4j.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-pg-availability" {
  bucket = "rzp-1415-prod-pg-availability"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-pg-availability.json}"

  versioning {
    enabled = false
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-pg-availability"
  }

  tags {
    name                      = "rzp-1415-prod-pg-availability"
    terraform                 = "true"
    bu                        = "payments"
    data_policy_label         = "private_data"
    environment               = "Production"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-pg-availability" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-pg-availability.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

#
resource "aws_s3_bucket" "rzp-1415-prod-axisbank-docs" {
  bucket = "rzp-1415-prod-axisbank-docs"
  acl    = "private"

  tags {
    name                      = "rzp-1415-prod-axisbank-docs"
    terraform                 = "true"
    bu                        = "platform"
    data_policy_label         = "private_data"
    environment               = "Production"
    "org.rzp.business-unit"   = "platform"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-axisbank-docs/"
  }

}

resource "aws_s3_bucket" "rzp-1415-prod-ipl-scaling" {
  bucket = "rzp-1415-prod-ipl-scaling"
  acl    = "private"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-ipl-scaling"
  }

  tags {
    name                      = "rzp-1415-prod-ipl-scaling"
    terraform                 = "true"
    bu                        = "payments"
    data_policy_label         = "private_data"
    environment               = "Production"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-ipl-scaling" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-ipl-scaling.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-mandate-hq" {
  bucket = "rzp-1415-prod-mandate-hq"
  acl    = "private"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-mandate-hq"
  }

    cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://*.mandatehq.com", "https://*.mandatehq.in", "https://mandatehq.razorpay.in"]
    max_age_seconds = 3000
  }


  tags {
    name                      = "rzp-1415-prod-mandate-hq"
    terraform                 = "true"
    data_policy_label         = "static_files"
    environment               = "Production"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-nvirignia-cf-access-logs" {
  provider = "aws.us"

  bucket = "${aws_s3_bucket.rzp-1415-nvirignia-cf-access-logs.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-nvirignia-cf-access-logs" {
  bucket   = "rzp-1415-nvirignia-cf-access-logs"
  provider = "aws.us"

  region = "us-east-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.s3accesslogsrzp-us-east-1.id}"
    target_prefix = "rzp-1415-nvirignia-cf-access-logs/"
  }

  grant {
    id          = "${local.cloudfront_canonical_id}"
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }

  tags {
    name                      = "rzp-1415-nvirignia-cf-access-logs"
    terraform                 = "true"
    data_policy_label         = "logs"
    environment               = "Production"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-settlement-service" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-settlement-service.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-settlement-service" {
  bucket = "rzp-1415-prod-settlement-service"
  acl    = "private"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-settlement-service"
  }

  tags {
    name                      = "rzp-1415-prod-settlement-service"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-sumo-partitioned-logs" {
  bucket = "rzp-1415-prod-sumo-partitioned-logs"
  acl    = "private"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-sumo-partitioned-logs"
  }

  tags {
    name                      = "rzp-1415-prod-sumo-partitioned-logs"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-security-alerts" {
  bucket = "${aws_s3_bucket.rzp-prod-security-alerts.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-security-alerts" {
  bucket = "rzp-prod-security-alerts"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-prod-security-alerts-policy.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-security-alerts"
  }

  tags {
    name                      = "rzp-prod-security-alerts"
    terraform                 = "true"
    bu                        = "security"
    data_policy_label         = "private_data"
    environment               = "Production"
    "org.rzp.business-unit"   = "security"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  cors_rule {
    max_age_seconds = 3000
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["https://admin-dashboard.razorpay.com"]
  }

}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-mandatehq-test-issuer-reports" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-mandatehq-test-issuer-reports.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-test-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-test-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-test-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-mandatehq-test-issuer-reports/"
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-mandatehq-oc-issuer-reports" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-mandatehq-oc-issuer-reports.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-oc-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-oc-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-oc-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
    logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-mandatehq-oc-issuer-reports/"
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-mandatehq-equitas-issuer-reports" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-mandatehq-equitas-issuer-reports.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-equitas-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-equitas-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-equitas-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-mandatehq-equitas-issuer-reports/"
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-mandatehq-hsbc-issuer-reports" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-mandatehq-hsbc-issuer-reports.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-hsbc-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-hsbc-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-hsbc-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-mandatehq-hsbc-issuer-reports/"
  }

}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-kvb-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-kvb-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-kvb-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-icici-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-icici-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-icici-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-cu-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-cu-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-cu-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-slice-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-slice-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-slice-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-pnb-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-pnb-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-pnb-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-indian-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-indian-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-indian-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-maha-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-maha-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-maha-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-mandatehq-razorpayx-issuer-reports" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-mandatehq-razorpayx-issuer-reports.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-razorpayx-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-razorpayx-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-razorpayx-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-iob-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-iob-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-iob-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-axis-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-axis-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-axis-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-jupiter-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-jupiter-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-jupiter-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-niyopay-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-niyopay-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-niyopay-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-mandatehq-psb-issuer-reports" {
  bucket = "rzp-1415-prod-mandatehq-psb-issuer-reports"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-mandatehq-psb-issuer-reports"
    terraform                 = "true"
    data_policy_label         = "client_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "apps"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-checkout" {
  bucket = "rzp-1415-prod-checkout"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-checkout.json}"

  versioning {
    enabled = false
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-checkout"
  }

  tags {
    name                      = "rzp-1415-prod-checkout"
    bu                        = "payments"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-xpayroll-compliance" {
  bucket = "rzp-1415-prod-xpayroll-compliance"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-xpayroll-compliance-policy.json}"

  versioning {
    enabled = false
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-xpayroll-compliance"
  }

  tags {
    name                      = "rzp-1415-prod-xpayroll-compliance"
    terraform                 = "true"
    data_policy_label         = "private_data"
    team                      = "xpayroll"
    environment               = "Production"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-xpayroll-private-assets" {
  bucket = "rzp-1415-prod-xpayroll-private-assets"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-xpayroll-private-assets-policy.json}"

  versioning {
    enabled = false
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-xpayroll-private-assets"
  }

  tags {
    name                      = "rzp-1415-prod-xpayroll-private-assets"
    terraform                 = "true"
    data_policy_label         = "private_data"
    team                      = "xpayroll"
    environment               = "Production"
    team                      = "xpayroll"
    bu                        = "razorpayx"
    "org.rzp.business-unit"   = "razorpayx"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-xpayroll-private-assets" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-xpayroll-private-assets.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-xpayroll-compliance" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-xpayroll-compliance.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-capital-market-service" {
  bucket = "rzp-prod-capital-marketplace-service"
  acl    = "private"
  region = "ap-south-1"
  policy = "${data.aws_iam_policy_document.rzp-prod-capital-market-service.json}"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${aws_s3_bucket.rzp-prod-object-logging-bucket.id}"
    target_prefix = "capital-marketplace/log/"
  }

  tags {
    name                      = "rzp-prod-capital-marketplace-service"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "capital"
    "org.rzp.business-unit"   = "capital"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-prod-capital-market-service" {
  bucket = "${aws_s3_bucket.rzp-prod-capital-market-service.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-prod-rto-prediction-service" {
  bucket = "rzp-1415-prod-rto-prediction-service"
  acl    = "private"

  tags {
    name                      = "rzp-1415-prod-rto-prediction-service"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    team                      = "1cc"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

    lifecycle_rule {
      id = "rto_prediction_aggregation_data_cleanup"

      enabled = true

      prefix = "airflow/aggregates/"

      expiration {
        days = 15
      }

      noncurrent_version_expiration {
        days = 15
      }
    }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-address-standardization" {
  bucket = "rzp-1415-prod-address-standardization"
  acl    = "private"

  tags = {
    name                      = "rzp-1415-prod-address-standardization"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    team                      = "1cc"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-cyberhelpdesk" {
  bucket = "rzp-1415-prod-cyberhelpdesk"
  acl    = "private"
  region = "ap-south-1"

  tags = {
    name                      = "rzp-1415-prod-cyberhelpdesk"
    terraform                 = "true"
    environment               = "prod"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-sumologic-logstore-2022" {
  bucket = "rzp-1415-prod-sumologic-logstore-2022"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-sumologic-logstore-2022.json}"


  tags {
    name                      = "rzp-1415-prod-sumologic-logstore-2022"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "shared"
    "org.rzp.business-unit"   = "shared"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-sumologic-logstore-2022/"
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-checkout-static" {
  bucket = "rzp-1415-prod-checkout-static"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-checkout-static.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-checkout-static"
  }

  tags {
    name                      = "rzp-1415-prod-checkout-static"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }



  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-checkout-static-canary" {
  bucket = "rzp-1415-prod-checkout-static-canary"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-checkout-static-canary.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-checkout-static-canary"
  }

  tags {
    name                      = "rzp-1415-prod-checkout-static-canary"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }



  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-checkout-static-baseline" {
  bucket = "rzp-1415-prod-checkout-static-baseline"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-checkout-static-baseline.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-checkout-static-baseline"
  }

  tags {
    name                      = "rzp-1415-prod-checkout-static-baseline"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }



  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-checkout-static-canary" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-checkout-static-canary.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-checkout-static" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-checkout-static.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-checkout-static-baseline" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-checkout-static-baseline.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-1415-ops-terraform-registry" {
  bucket = "rzp-1415-ops-terraform-registry"
  acl    = "private"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-ops-terraform-registry"
  }

  tags {
    name                      = "rzp-1415-ops-terraform-registry"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "devops"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-ops-terraform-registry" {
  bucket = "${aws_s3_bucket.rzp-1415-ops-terraform-registry.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-mysql-query-logs" {
  bucket = "rzp-mysql-query-logs"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-mysql-query-logs/"
  }

  tags {
    name                      = "rzp-mysql-query-logs"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "all"
    "org.rzp.business-unit"   = "shared"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-mysql-query-logs" {
  bucket = "${aws_s3_bucket.rzp-mysql-query-logs.id}"
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}


resource "aws_s3_bucket" "rzp-prod-mandate-manager-fe" {
  bucket = "rzp-prod-mandate-manager-fe"
  acl    = "private"
  region = "ap-south-1"

  versioning {
    enabled = true
  }

  tags {
    name                      = "rzp-prod-mandate-manager-fe"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-mandate-manager-fe/"
  }

}


resource "aws_s3_bucket" "rzp-1415-prod-hdfc-collect-now-settlement" {
  bucket = "rzp-1415-prod-hdfc-collect-now-settlement"
  acl    = "private"
  region = "ap-south-1"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-hdfc-collect-now-settlement"
  }

  tags {
    name                      = "rzp-1415-prod-hdfc-collect-now-settlement"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-legal-documents" {
  bucket = "rzp-1415-prod-legal-documents"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-legal-documents"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "platform"
    team                      = "merchant_identity"
    "org.rzp.business-unit"   = "platform"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-ocr-model-training-documents" {
  bucket = "rzp-1415-prod-ocr-model-training-documents"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-ocr-model-training-documents"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "platform"
    team                      = "merchant_identity"
    "org.rzp.business-unit"   = "platform"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-cyber-helpdesk-documents" {
  bucket = "rzp-1415-prod-cyber-helpdesk-documents"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-cyber-helpdesk-documents"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "payments"
    team                      = "risk"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-csw-custom-reports" {
  bucket = "rzp-1415-prod-csw-custom-reports"
  acl    = "private"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-csw-custom-reports"
  }

  lifecycle_rule {
    id = "data_clean_up"

    enabled = true

    expiration {
      days = 180
    }

    noncurrent_version_expiration {
      days = 180
    }
  }

  tags = {
    name                      = "rzp-1415-prod-csw-custom-reports"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "stage"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Lambda@edge requires S3 assets to be fetched from bucket only in us-east-1 region.
# This bucket will store the zipped files required for the lambda@edge functions
resource "aws_s3_bucket" "rzp-1415-prod-frontend-lambda-assets" {
  bucket = "rzp-1415-prod-frontend-lambda-assets"
  acl    = "private"
  region = "us-east-1"
  provider = "aws.us"

  tags {
    Name                      = "rzp-1415-prod-frontend-lambda-assets"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "platform"
    team                      = "frontend"
    "org.rzp.business-unit"   = "platform"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-rto-merchant-file-uploads" {
  bucket = "rzp-1415-prod-rto-merchant-file-uploads"
  acl    = "private"
  region = "ap-south-1"

  lifecycle_rule {
    id = "rto_merchant_file_data_cleanup"

    enabled = true

    expiration {
      days = 7
    }

    noncurrent_version_expiration {
      days = 7
    }
  }

  tags = {
    name                      = "rzp-1415-prod-rto-merchant-file-uploads"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "Production"
    bu                        = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp-1415-prod-amazonpay" {
  bucket = "rzp-1415-prod-amazonpay"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.rzp-1415-prod-amazonpay.json}"

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-1415-prod-amazonpay/"
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${data.aws_kms_key.rzp-1415-prod-amazonpay.arn}"
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags {
    name              = "rzp-1415-prod-amazonpay"
    terraform         = "true"
    data_policy_label = "private_data"
    bu                = "payments"
    "org.rzp.environment" = "production"
    "org.rzp.business-unit" = "payments"
    environment       = "Production"
    team              = "apps"
    jira              = "https://jira.corp.razorpay.com/browse/BAD-5810"
  }
}

resource "aws_s3_bucket_public_access_block" "rzp-1415-prod-amazonpay" {
  bucket = "${aws_s3_bucket.rzp-1415-prod-amazonpay.id}"

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket" "rzp-prod-merchant-assets" {
  bucket = "rzp-prod-merchant-assets"
  acl    = "public-read"
  policy = "${data.aws_iam_policy_document.rzp-prod-merchant-assets-public-read.json}"

  versioning {
    enabled = true
  }

  tags {
    name              = "rzp-prod-merchant-assets"
    terraform         = "true"
    data_policy_label = "client_data"
    environment       = "prod"
    team              = "merchant_experience"
    bu                = "payments"
    "org.rzp.business-unit"   = "payments"
    "org.rzp.environment"     = "production"

  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-prod-merchant-assets/"
  }
}



resource "aws_s3_bucket" "rzp-idocs" {
  bucket = "rzp-idocs"

  tags {
    name              = "rzp-idocs"
    bu                = "devops"
    terraform         = "true"
    data_policy_label = "private_data"
    environment       = "Production"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/prod/rzp-idocs/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}


resource "aws_s3_bucket" "rzp_drone_logs" {
  bucket = "rzp-drone-logs"

  tags {
    Name              = "rzp-drone-logs"
    bu                = "devops"
    terraform         = "true"
    data_policy_label = "private_data"
    environment       = "noncde"
    "org.rzp.business-unit"   = "devops"
    "org.rzp.environment"     = "production"
    team              = "devops"
  }

  logging {
    target_bucket = "${data.aws_s3_bucket.rzp-aws-logs.id}"
    target_prefix = "s3/ops/rzp-drone-logs/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-ocr-website-verification-pages" {
  bucket = "rzp-1415-prod-ocr-website-verification-pages"
  acl    = "private"
  region = "ap-south-1"

  tags = {
    Name                      = "rzp-1415-prod-ocr-website-verification-pages"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "platform"
    team                      = "merchant_identity"
    "org.rzp.business-unit"   = "platform"
    "org.rzp.environment"     = "production"
  }

  lifecycle_rule {
    id = "data_clean_up"
    enabled = true

    expiration {
      days = 90
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "rzp-1415-prod-bvs-kyc-documents" {
  bucket = "rzp-1415-prod-bvs-kyc-documents"
  acl    = "private"
  region = "ap-south-1"

  tags {
    Name                      = "rzp-1415-prod-bvs-kyc-documents"
    terraform                 = "true"
    data_policy_label         = "private_data"
    environment               = "prod"
    bu                        = "platform"
    team                      = "merchant_identity"
    "org.rzp.business-unit"   = "platform"
    "org.rzp.environment"     = "production"
  }

  lifecycle_rule {
    id = "Remove files from bucket"
    enabled = true

    expiration {
      days = 30
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
