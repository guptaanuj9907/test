# payment nbplus
data "aws_iam_policy_document" "payments_nbplus_policy_documents" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payments-nbplus-api-reconciliation-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payments-nbplus-api-reconciliation-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-api-es-sync",
    ]
  }
}

# payment nbplus dark
data "aws_iam_policy_document" "payments_nbplus_policy_documents_dark" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-payments-nbplus-api-reconciliation-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-payments-nbplus-api-reconciliation-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-api-es-sync",
    ]
  }
}

# care iam policy
data "aws_iam_policy_document" "care_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-callback-push-to-myoperator",
    ]
  }
}

#vendor_payments
data "aws_iam_policy_document" "vendor_payments_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-vendor-payments-invoices/*",
      "arn:aws:s3:::rzp-prod-vendor-payments-invoices",
    ]
  }
}

#ClusterAutoscaler
data "aws_iam_policy_document" "clusterautoscaler_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions",
    ]

    resources = [
      "*",
    ]
  }
}

# razorx
data "aws_iam_policy_document" "razorx_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:${var.account_id}:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:${var.account_id}:table/credstash-prod-razorx",
    ]
  }
}

#batch
data "aws_iam_policy_document" "batch_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-batch",
      "arn:aws:s3:::rzp-edh-prod",
      "arn:aws:s3:::rzp-1415-prod-batch-payments",
      "arn:aws:s3:::rzp-1415-prod-batch-razorpayx",
      "arn:aws:s3:::rzp-1415-prod-batch-capital",
      "arn:aws:s3:::rzp-1415-prod-batch-platform",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-batch/*",
      "arn:aws:s3:::rzp-edh-prod/*",
      "arn:aws:s3:::rzp-1415-prod-batch-payments/*",
      "arn:aws:s3:::rzp-1415-prod-batch-razorpayx/*",
      "arn:aws:s3:::rzp-1415-prod-batch-capital/*",
      "arn:aws:s3:::rzp-1415-prod-batch-platform/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-batch",
      "arn:aws:sqs:ap-south-1:141592612890:prod-batch-sftp",
      "arn:aws:sqs:ap-south-1:141592612890:prod-batch-sqs-art-dual-write",
      "arn:aws:sqs:ap-south-1:141592612890:prod-batch-sqs-reconciliation",
      "arn:aws:sqs:ap-south-1:141592612890:prod-batch-sqs-art-prs",
    ]
  }
}

#Credstash-ui
data "aws_iam_policy_document" "credstash_ui_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:GenerateDataKey",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:BatchGetItem",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:ListTables",
    ]

    resources = [
      "*",
    ]
  }
}

#doppler
data "aws_iam_policy_document" "doppler_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-doppler-config/*",
      "arn:aws:s3:::rzp-prod-doppler-config",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::raas-dev/*",
      "arn:aws:s3:::raas-dev",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }
}

#Entity-processor
data "aws_iam_policy_document" "entity_processor_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
    ]

    resources = [
      "arn:aws:s3:::rzp-thirdwatch/*",
      "arn:aws:s3:::rzp-thirdwatch",
      "arn:aws:s3:::rzp-prod-edh-events/*",
      "arn:aws:s3:::rzp-prod-edh-events",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-config/*",
      "arn:aws:s3:::rzp-config",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-datahub",
    ]
  }
}

#events-stream
data "aws_iam_policy_document" "events_stream_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-edh-events/*",
      "arn:aws:s3:::rzp-prod-edh-events",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-config/*",
      "arn:aws:s3:::rzp-config",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-datahub",
    ]
  }
}

#financial-data-service
data "aws_iam_policy_document" "financial_data_service_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-financial-data-service-dlq-sqs",
      "arn:aws:sqs:ap-south-1:141592612890:prod-financial-data-service",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-financial-data-service/*",
      "arn:aws:s3:::rzp-prod-financial-data-service",
    ]
  }
}

#fts
data "aws_iam_policy_document" "fts_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-fts",
    ]
  }
}

data "aws_iam_policy_document" "fts_s3_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObjectVersion",
      "s3:DeleteObject",
      "s3:GetObjectVersion",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-sftp/axis/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "axis/*",
        "axis",
      ]
    }

    resources = [
      "arn:aws:s3:::rzp-1415-prod-sftp",
    ]
  }
}

#fts_dark
data "aws_iam_policy_document" "fts_dark_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-fts",
    ]
  }
}

data "aws_iam_policy_document" "fts_dark_s3_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObjectVersion",
      "s3:DeleteObject",
      "s3:GetObjectVersion",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-sftp/axis/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "axis/*",
        "axis",
      ]
    }

    resources = [
      "arn:aws:s3:::rzp-1415-prod-sftp",
    ]
  }
}

#ifsc
data "aws_iam_policy_document" "ifsc_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-ifsc",
    ]
  }
}

#kubestash
data "aws_iam_policy_document" "kubestash_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:ListStreams",
      "dynamodb:GetShardIterator",
      "dynamodb:GetRecords",
      "dynamodb:GetItem",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeStream",
      "dynamodb:BatchGetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/kubestash-prod",
    ]
  }
}

#kyc
data "aws_iam_policy_document" "kyc_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-kyc-requests",
    ]
  }
}

#offline-verification
data "aws_iam_policy_document" "offline_verification_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-offline-verification-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-offline-verification",
    ]
  }
}

#outline
data "aws_iam_policy_document" "outline_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-outline-wiki/*",
      "arn:aws:s3:::rzp-prod-outline-wiki",
    ]
  }
}

#payment-links
data "aws_iam_policy_document" "payment_links_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
      "es:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-webhook",
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-sms",
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-reminder",
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-expire",
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-email",
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-elastic",
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-merchantrisk",
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-reminderscallback",
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-payment-failed-retry",
      "arn:aws:sqs:ap-south-1:141592612890:prod-payment-links-whatsapp",
      "arn:aws:es:ap-south-1:141592612890:domain/prod-payment-links-es",
    ]
  }
}

#payout-links
data "aws_iam_policy_document" "payout_links_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-payout-links-sms",
      "arn:aws:s3:::rzp-1415-prod-payout-attachments/*"
    ]
  }
}

#rds-snapshot
data "aws_iam_policy_document" "rds_snapshot_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "rds:CreateDBSnapshot",
      "rds-db:connect",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-rds-snapshot-coordinates/*",
      "arn:aws:rds:ap-south-1:141592612890:snapshot:*",
      "arn:aws:rds:ap-south-1:141592612890:db:prod-api-mysql-p5-live-replica-backup",
      "arn:aws:rds-db:ap-south-1:141592612890:dbuser:db-SIZHCCPA4GYY5M27KS7PXRZH54/rdsbkp_user"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "rds:DescribeDBSnapshots",
      "rds:DeleteDBSnapshot",
    ]

    resources = [
      "*",
    ]
  }
}

#recon
data "aws_iam_policy_document" "recon_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-recon-prod/*",
      "arn:aws:s3:::rzp-recon-prod",
      "arn:aws:s3:::rzp-config/*",
      "arn:aws:s3:::rzp-config",
      "arn:aws:s3:::qb-data-analysis/*",
      "arn:aws:s3:::qb-data-analysis",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::prod-us-h2h",
      "arn:aws:s3:::prod-us-h2h/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-sftp",
      "arn:aws:s3:::rzp-1415-prod-sftp/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:164294033593:prod-recon-file-fetch",
    ]
  }
}

#report-studio
data "aws_iam_policy_document" "report_studio_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:164294033593:prod-reporting-notification",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-report-studio/*",
      "arn:aws:s3:::rzp-report-studio",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::rzp-warehouse/*",
      "arn:aws:s3:::rzp-warehouse",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-config/*",
      "arn:aws:s3:::rzp-config",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-report-studio",
    ]
  }
}

#scrooge-dark
data "aws_iam_policy_document" "scrooge_dark_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-scrooge",
    ]
  }
}

#stork
data "aws_iam_policy_document" "stork_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-stork",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-webhook-processing",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-webhook-p1",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-webhook-p2",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-reminders-webhook-p1",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-reminders-webhook-p2",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-reminders-webhook-p1-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-reminders-webhook-p2-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-webhook",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-sms-p2",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-sms-p1",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-sms-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-sms",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-whatsapp",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-whatsapp-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-email",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-email-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-pushn",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-pushn-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-email-delivery-status",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-email-delivery-status-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-sms-delivery-status",
      "arn:aws:sqs:ap-south-1:141592612890:prod-stork-sms-delivery-status-dlq"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
      "mobiletargeting:SendUsersMessages",
      "mobiletargeting:SendMessages",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-stork/*",
      "arn:aws:s3:::rzp-prod-stork",
      "arn:aws:mobiletargeting:ap-south-1:141592612890:apps/ade90625b4624a1ab999447af4f47847/messages",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-email-templates",
      "arn:aws:s3:::rzp-prod-email-templates/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = ["ses:SendRawEmail", "ses:SendEmail"]

    resources = [
      "arn:aws:ses:ap-south-1:141592612890:identity/razorpay.com",
      "arn:aws:ses:ap-south-1:141592612890:configuration-set/prod-stork-ses-events",
      "arn:aws:ses:ap-south-1:141592612890:identity/mandatehq.com",
      "arn:aws:ses:ap-south-1:141592612890:identity/curlec.com",
    ]
  }

  statement {
         effect = "Allow"

         actions = [
           "s3:PutObject",
           "s3:GetObject",
         ]

         resources = [
           "arn:aws:s3:::rzp-1415-prod-stork-attachments",
           "arn:aws:s3:::rzp-1415-prod-stork-attachments/*",
         ]
       }
}

#verdaccio
data "aws_iam_policy_document" "verdaccio_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-npm-registry/*",
      "arn:aws:s3:::rzp-prod-npm-registry",
    ]
  }
}

#atlantis
data "aws_iam_policy_document" "atlantis_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "*",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectTagging",
      "s3:GetObject",
      "s3:GetBucketTagging",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-ops-bucket/*",
      "arn:aws:s3:::rzp-ops-bucket",
      "arn:aws:s3:::rzp-artifacts/*",
      "arn:aws:s3:::rzp-artifacts",
    ]
  }
}

data "aws_iam_policy_document" "reporting_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-reporting",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-reporting",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-reporting-scheduled",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-reporting-slowjobs",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-reporting-largejobs",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-reporting-spark",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-reporting-sparkjob-failures",
      "arn:aws:sqs:ap-south-1:${var.qubole_prod_account}:prod-reporting-notification",
    ]
  }
}

data "aws_iam_policy_document" "reporting-s3-policy-documents" {

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
  ]

    resources = [
      "arn:aws:s3:::rzp-config",
      "arn:aws:s3:::rzp-config/*",
    ]
  }
}

data "aws_iam_policy_document" "settlements_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-execution-verify",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlements-create",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlements-initiate",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlements-status-update",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlement-report-notification",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlements-transaction-recorder",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlements-transaction-update",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlements-trigger",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-execution-verify",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlements-create",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlements-initiate",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlements-status-update",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlement-report-notification",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlements-transaction-recorder",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlements-transaction-update",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlements-trigger",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlement-pagination",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlement-pagination",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlement-notification",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlement-notification",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlements-merchants-events",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlements-merchants-events",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-live-settlements-entity-alert",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-test-settlements-entity-alert",
    ]
  }
}

data "aws_iam_policy_document" "prod_capital_cards_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sqs:*"]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-cards-send-sms",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-cards-create-card",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-cards-create-cardholder",
    ]
  }
}

data "aws_iam_policy_document" "prod_capital_collections_policy_document" {
  statement {
    effect  = "Allow"
    actions = ["sqs:*"]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-collections-plan-loc-notifications",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-collections-repayment-loc-notifications",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-collections-autocollect-installments",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-collections-credit-repayment-retry",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-collections-process-installments",
    ]
  }
}

# Subscriptions

data "aws_iam_policy_document" "subscriptions_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:${var.account_id}:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:${var.account_id}:table/credstash-prod-subscriptions",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-subscriptions-webhook",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-subscriptions-slack",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-subscriptions-payment-notify",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-subscriptions-mail",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-subscriptions-charge",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-subscriptions-upi-charge",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-subscriptions-merchant-risk",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-subscriptions-create-invoice",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-email-templates",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-email-templates/*",
    ]
  }
}

#auth
data "aws_iam_policy_document" "auth_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-auth",
    ]
  }
}

#butler
data "aws_iam_policy_document" "butler_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-butler",
    ]
  }
}

#concierge
data "aws_iam_policy_document" "concierge_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-concierge",
    ]
  }
}

# concierge iam policy
data "aws_iam_policy_document" "concierge_policy" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeSecurityGroups",
      "s3:GetBucketTagging",
      "s3:PutBucketPolicy",
      "s3:GetBucketPolicy"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:RevokeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupIngress",
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/concierge"

      values = [
        "true",
      ]
    }
  }
}

#dashboard
data "aws_iam_policy_document" "dashboard_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-dashboard",
    ]
  }
}

data "aws_iam_policy_document" "dashboard_s3_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::rzp-dashboard-activation/*",
      "arn:aws:s3:::rzp-dashboard-activation",
      "arn:aws:s3:::dashboard-activation/*",
      "arn:aws:s3:::dashboard-activation",
      "arn:aws:s3:::rzp-1415-prod-dashboard-activation/*",
      "arn:aws:s3:::rzp-1415-prod-dashboard-activation",
      "arn:aws:s3:::rzp-recon-prod/*",
      "arn:aws:s3:::rzp-recon-prod",
    ]
  }
}

#gimli
data "aws_iam_policy_document" "gimli_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-gimli",
    ]
  }
}

#harvester
data "aws_iam_policy_document" "harvester_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-harvester",
    ]
  }
}

data "aws_iam_policy_document" "harvester_s3_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-athena/*",
      "arn:aws:s3:::rzp-prod-athena",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::rzp-entity-schemas/harvester-v2-result/*",
      "arn:aws:s3:::rzp-entity-schemas/harvester-v2-result",
    ]
  }
}

#datahub
data "aws_iam_policy_document" "datahub_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-datahub",
    ]
  }
}

data "aws_iam_policy_document" "datahub_s3_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-warehouse/*",
      "arn:aws:s3:::rzp-warehouse",
      "arn:aws:s3:::rzp-prod-events/*",
      "arn:aws:s3:::rzp-prod-events",
      "arn:aws:s3:::rzp-prod-edh-events/*",
      "arn:aws:s3:::rzp-prod-edh-events",
      "arn:aws:s3:::rzp-prod-datum/*",
      "arn:aws:s3:::rzp-prod-datum",
      "arn:aws:s3:::rzp-entity-schemas/*",
      "arn:aws:s3:::rzp-entity-schemas",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::qb-data-analysis/*",
      "arn:aws:s3:::qb-data-analysis",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-config/*",
      "arn:aws:s3:::rzp-config",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListMultipartUploadParts",
      "s3:ListBucketMultipartUploads",
      "s3:AbortMultipartUpload",
      "s3:PutObjectVersionAcl",
    ]

    resources = [
      "arn:aws:s3:::rzp-finance-data/*",
      "arn:aws:s3:::rzp-finance-data",
    ]
  }
}

data "aws_iam_policy_document" "datahub_sqs_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:SendMessageBatch",
      "sqs:SendMessage",
      "sqs:ReceiveMessage",
      "sqs:ListQueueTags",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:GetQueueUrl",
      "sqs:GetQueueAttributes",
      "sqs:DeleteMessage",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-reporting-sparkjob-failures",
    ]
  }
}

#hosted
data "aws_iam_policy_document" "hosted_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-hosted",
    ]
  }
}

#ufh
data "aws_iam_policy_document" "ufh_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-ufh",
    ]
  }
}

data "aws_iam_policy_document" "ufh_s3_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::rzp-report-studio",
      "arn:aws:s3:::rzp-prod-vendor-payments-invoices",
      "arn:aws:s3:::rzp-prod-ufh-admin",
      "arn:aws:s3:::rzp-prod-splitz",
      "arn:aws:s3:::rzp-prod-scrooge",
      "arn:aws:s3:::rzp-prod-reports",
      "arn:aws:s3:::rzp-prod-paper-mandates",
      "arn:aws:s3:::rzp-prod-merchant-assets",
      "arn:aws:s3:::rzp-prod-api-invoices",
      "arn:aws:s3:::rzp-api-reconciliation",
      "arn:aws:s3:::rzp-1415-prod-facebook",
      "arn:aws:s3:::prod-us-h2h",
      "arn:aws:s3:::prod-ufh-reports",
      "arn:aws:s3:::dashboard-activation",
      "arn:aws:s3:::checkout-live",
      "arn:aws:s3:::api-settlement",
      "arn:aws:s3:::rzp-recon-prod",
      "arn:aws:s3:::rzp-1415-prod-settlement-service",
      "arn:aws:s3:::rzp-1415-prod-capital-cards-statements",
      "arn:aws:s3:::rzp-1415-prod-sftp",
      "arn:aws:s3:::rzp-1642-prod-nps",
      "arn:aws:s3:::rzp-1415-prod-growth-service",
      "arn:aws:s3:::rzp-1415-prod-growth-service/*",
      "arn:aws:s3:::rzp-api-customer",
      "arn:aws:s3:::rzp-1415-prod-api-invoices",
      "arn:aws:s3:::rzp-1415-prod-api-settlement",
      "arn:aws:s3:::rzp-1415-prod-api-settlement/*",
      "arn:aws:s3:::rzp-1415-prod-dashboard-activation",
      "arn:aws:s3:::rzp-1415-prod-dashboard-activation/*",
      "arn:aws:s3:::rzp-1415-prod-payout-attachments",
      "arn:aws:s3:::rzp-1415-prod-batch-payments",
      "arn:aws:s3:::rzp-1415-prod-batch-payments/*",
      "arn:aws:s3:::rzp-1415-prod-batch-razorpayx",
      "arn:aws:s3:::rzp-1415-prod-batch-razorpayx/*",
      "arn:aws:s3:::rzp-1415-prod-batch-capital",
      "arn:aws:s3:::rzp-1415-prod-batch-capital/*",
      "arn:aws:s3:::rzp-1415-prod-batch-platform",
      "arn:aws:s3:::rzp-1415-prod-batch-platform/*",
      "arn:aws:s3:::rzp-1415-prod-hdfc-collect-now-settlement",
      "arn:aws:s3:::rzp-1415-prod-hdfc-collect-now-settlement/*",
      "arn:aws:s3:::rzp-1415-prod-legal-documents",
      "arn:aws:s3:::rzp-1415-prod-legal-documents/*",
      "arn:aws:s3:::rzp-1415-prod-cross-border-bucket",
      "arn:aws:s3:::rzp-1415-prod-cross-border-bucket/*",
      "arn:aws:s3:::rzp-1415-prod-ocr-model-training-documents",
      "arn:aws:s3:::rzp-1415-prod-ocr-model-training-documents/*",
      "arn:aws:s3:::rzp-1415-prod-cyber-helpdesk-documents",
      "arn:aws:s3:::rzp-1415-prod-cyber-helpdesk-documents/*",
      "arn:aws:s3:::rzp-1415-prod-accounts-receivable",
      "arn:aws:s3:::rzp-1415-prod-accounts-receivable/*",
      "arn:aws:s3:::rzp-1415-prod-rto-merchant-file-uploads",
      "arn:aws:s3:::rzp-1415-prod-rto-merchant-file-uploads/*",
      "arn:aws:s3:::rzp-1415-prod-fulcrum-axis-refund",
      "arn:aws:s3:::rzp-1415-prod-fulcrum-axis-refund/*",
      "arn:aws:s3:::rzp-1415-prod-frontend-rize",
      "arn:aws:s3:::rzp-1415-prod-frontend-rize/*",
      "arn:aws:s3:::razorpay-sftp",
      "arn:aws:s3:::razorpay-sftp/*",
      "arn:aws:s3:::rzp-1415-prod-bvs-kyc-documents",
      "arn:aws:s3:::rzp-1415-prod-bvs-kyc-documents/*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-report-studio/*",
      "arn:aws:s3:::rzp-prod-vendor-payments-invoices/*",
      "arn:aws:s3:::rzp-prod-ufh-admin/*",
      "arn:aws:s3:::rzp-prod-splitz/*",
      "arn:aws:s3:::rzp-prod-scrooge/*",
      "arn:aws:s3:::rzp-prod-reports/*",
      "arn:aws:s3:::rzp-prod-paper-mandates/*",
      "arn:aws:s3:::rzp-prod-merchant-assets/*",
      "arn:aws:s3:::rzp-prod-api-invoices/*",
      "arn:aws:s3:::rzp-api-reconciliation/*",
      "arn:aws:s3:::rzp-1415-prod-facebook/*",
      "arn:aws:s3:::prod-us-h2h/*",
      "arn:aws:s3:::prod-ufh-reports/*",
      "arn:aws:s3:::dashboard-activation/*",
      "arn:aws:s3:::checkout-live/*",
      "arn:aws:s3:::api-settlement/*",
      "arn:aws:s3:::rzp-recon-prod/*",
      "arn:aws:s3:::rzp-1415-prod-settlement-service/*",
      "arn:aws:s3:::rzp-1415-prod-capital-cards-statements/*",
      "arn:aws:s3:::rzp-1415-prod-sftp/*",
      "arn:aws:s3:::rzp-1642-prod-nps/*",
      "arn:aws:s3:::rzp-1642-prod-nps",
      "arn:aws:s3:::rzp-1415-prod-growth-service",
      "arn:aws:s3:::rzp-1415-prod-growth-service/*",
      "arn:aws:s3:::rzp-api-customer/*",
      "arn:aws:s3:::rzp-1415-prod-api-invoices/*",
      "arn:aws:s3:::rzp-1415-prod-api-settlement",
      "arn:aws:s3:::rzp-1415-prod-api-settlement/*",
      "arn:aws:s3:::rzp-1415-prod-dashboard-activation",
      "arn:aws:s3:::rzp-1415-prod-dashboard-activation/*",
      "arn:aws:s3:::rzp-1415-prod-payout-attachments/*",
      "arn:aws:s3:::rzp-1415-prod-batch-payments",
      "arn:aws:s3:::rzp-1415-prod-batch-payments/*",
      "arn:aws:s3:::rzp-1415-prod-batch-razorpayx",
      "arn:aws:s3:::rzp-1415-prod-batch-razorpayx/*",
      "arn:aws:s3:::rzp-1415-prod-batch-capital",
      "arn:aws:s3:::rzp-1415-prod-batch-capital/*",
      "arn:aws:s3:::rzp-1415-prod-batch-platform",
      "arn:aws:s3:::rzp-1415-prod-batch-platform/*",
      "arn:aws:s3:::rzp-1415-prod-hdfc-collect-now-settlement",
      "arn:aws:s3:::rzp-1415-prod-hdfc-collect-now-settlement/*",
      "arn:aws:s3:::rzp-1415-prod-legal-documents",
      "arn:aws:s3:::rzp-1415-prod-legal-documents/*",
      "arn:aws:s3:::rzp-1415-prod-cross-border-bucket",
      "arn:aws:s3:::rzp-1415-prod-cross-border-bucket/*",
      "arn:aws:s3:::rzp-1415-prod-ocr-model-training-documents",
      "arn:aws:s3:::rzp-1415-prod-ocr-model-training-documents/*",
      "arn:aws:s3:::rzp-1415-prod-cyber-helpdesk-documents",
      "arn:aws:s3:::rzp-1415-prod-cyber-helpdesk-documents/*",
      "arn:aws:s3:::rzp-1415-prod-accounts-receivable",
      "arn:aws:s3:::rzp-1415-prod-accounts-receivable/*",
      "arn:aws:s3:::rzp-1415-prod-rto-merchant-file-uploads",
      "arn:aws:s3:::rzp-1415-prod-rto-merchant-file-uploads/*",
      "arn:aws:s3:::rzp-1415-prod-fulcrum-axis-refund",
      "arn:aws:s3:::rzp-1415-prod-fulcrum-axis-refund/*",
      "arn:aws:s3:::rzp-1415-prod-frontend-rize",
      "arn:aws:s3:::rzp-1415-prod-frontend-rize/*",
      "arn:aws:s3:::razorpay-sftp",
      "arn:aws:s3:::razorpay-sftp/*",
      "arn:aws:s3:::rzp-1415-prod-bvs-kyc-documents",
      "arn:aws:s3:::rzp-1415-prod-bvs-kyc-documents/*",
    ]
  }
}

data "aws_iam_policy_document" "ufh_s3_external_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::razorpay-meatigo/*",
      "arn:aws:s3:::razorpay-meatigo",
      "arn:aws:s3:::zppl-zpayments/*",
      "arn:aws:s3:::zppl-zpayments"
    ]
  }
}

data "aws_iam_policy_document" "ufh_s3_nps_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketAcl"
    ]

    resources = [
      "arn:aws:s3:::rzp-1642-prod-nps/*",
      "arn:aws:s3:::rzp-1642-prod-nps",
    ]
  }
}

data "aws_iam_policy_document" "ufh_sqs_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-api-ufh-beam-test",
      "arn:aws:sqs:ap-south-1:141592612890:prod-api-ufh-beam-live",
      "arn:aws:sqs:ap-south-1:141592612890:prod-api-ufh-bulk-live",
      "arn:aws:sqs:ap-south-1:141592612890:prod-api-ufh-bulk-test",
    ]
  }
}

#lumberjack
data "aws_iam_policy_document" "lumberjack_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-lumberjack",
    ]
  }
}

#datahub-entity-processor
data "aws_iam_policy_document" "datahub-entity-processor_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-datahub",
    ]
  }
}

data "aws_iam_policy_document" "datahub-entity-processor_s3_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
    ]

    resources = [
      "arn:aws:s3:::rzp-thirdwatch/*",
      "arn:aws:s3:::rzp-thirdwatch",
      "arn:aws:s3:::rzp-prod-edh-events/*",
      "arn:aws:s3:::rzp-prod-edh-events",
      "arn:aws:s3:::rzp-entity-schemas/*",
      "arn:aws:s3:::rzp-entity-schemas",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-config/*",
      "arn:aws:s3:::rzp-config",
    ]
  }
}

#datahub-events-stream
data "aws_iam_policy_document" "datahub-events-stream_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-datahub",
    ]
  }
}

data "aws_iam_policy_document" "datahub-events-stream_s3_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
      "s3:AbortMultipartUpload",
    ]

    resources = [
      "arn:aws:s3:::rzp-thirdwatch/*",
      "arn:aws:s3:::rzp-thirdwatch",
      "arn:aws:s3:::rzp-prod-edh-events/*",
      "arn:aws:s3:::rzp-prod-edh-events",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-config/*",
      "arn:aws:s3:::rzp-config",
    ]
  }
}

data "aws_iam_policy_document" "governor_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "es:*",
    ]

    resources = [
      "arn:aws:es:ap-south-1:${var.account_id}:domain/prod-governor-es",
    ]
  }
}

#shield
data "aws_iam_policy_document" "shield_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "sqs:*",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
      "arn:aws:sqs:ap-south-1:${var.account_id}:${var.environment}-shield-create-rule-analytics",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-shield",
    ]
  }
}

#scrooge
data "aws_iam_policy_document" "scrooge_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-scrooge",
    ]
  }
}

#raven
data "aws_iam_policy_document" "raven_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:141592612890:table/credstash-prod-raven",
    ]
  }
}

data "aws_iam_policy_document" "raven_sqs_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-raven",
    ]
  }
}

#Razorpay-links
data "aws_iam_policy_document" "razorpay_links_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-razorpay-links",
      "arn:aws:s3:::rzp-1415-prod-razorpay-links/*",
    ]
  }
}

# TiDB
data "aws_iam_policy_document" "tidb_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-tidb-backup",
      "arn:aws:s3:::rzp-1415-tidb-backup/*",
      "arn:aws:s3:::rzp-1415-tidb-reporting-backup",
      "arn:aws:s3:::rzp-1415-tidb-reporting-backup/*",
    ]
  }
}

# mysql slow logs
data "aws_iam_policy_document" "mysql_slow_logs_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-mysql-query-logs",
      "arn:aws:s3:::rzp-mysql-query-logs/*",
    ]
  }
}


# Druid service iam policy for bucket access, prod-druid in qubole

data "aws_iam_policy_document" "prod-druid" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-druid/*",
      "arn:aws:s3:::rzp-prod-druid",
      "arn:aws:s3:::rzp-prod-druid-logs/*",
      "arn:aws:s3:::rzp-prod-druid-logs",
    ]
  }
}

#Neo4j
data "aws_iam_policy_document" "neo4j_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:ListMultipartUploadParts",
      "s3:ListBucket",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:AbortMultipartUpload",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-neo4j/*",
      "arn:aws:s3:::rzp-prod-neo4j",
    ]
  }
}

#pinot

data "aws_iam_policy_document" "pinot_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-pinot/*",
      "arn:aws:s3:::rzp-prod-pinot",
    ]
  }
}

#PG Availability Policy Document
data "aws_iam_policy_document" "pg_availability_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:PutObjectAcl",
      "s3:ListBucket",
      "s3:ListObjectsV2",
      "s3:GetObjectAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-pg-availability/*",
      "arn:aws:s3:::rzp-1415-prod-pg-availability",
    ]
  }
}

# Templating Service
data "aws_iam_policy_document" "templating_service_s3_write_policy_documents" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-email-templates",
      "arn:aws:s3:::rzp-prod-email-templates/*",
    ]
  }
}

# Razorflow
data "aws_iam_policy_document" "razorflow_policy_documents" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:PutObjectAcl",
      "s3:ListBucket",
      "s3:ListObjectsV2",
      "s3:GetObjectAcl",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-ipl-scaling/*",
      "arn:aws:s3:::rzp-1415-prod-ipl-scaling",
    ]
  }
}

# ledger iam policy
data "aws_iam_policy_document" "ledger_policy_documents" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-journal-create-test",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-account-create-test",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-balance-update-test",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-entry-details-create-test",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-balance-update-pg-test",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-entry-details-create-pg-test",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-journal-create-live",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-account-create-live",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-balance-update-live",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-entry-details-create-live",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-balance-update-pg-live",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-entry-details-create-pg-live",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-namespace-refresh-test",
      "arn:aws:sqs:ap-south-1:141592612890:prod-ledger-namespace-refresh-live",
    ]
  }
}

# warehouse-web iam policy
data "aws_iam_policy_document" "warehouse_web_policy_documents" {
  statement {
    sid = "s3accessforwarehousewebservice"

    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::rzp-1642-airflow/*",
      "arn:aws:s3:::rzp-1642-airflow",
      "arn:aws:s3:::rzp-warehouse/config/prod",
      "arn:aws:s3:::rzp-warehouse/config/prod/*",
    ]
  }

  statement {
    sid = "s3accessfordeletingobjects"

    effect = "Allow"

    actions = [
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-1642-airflow/dags/*",
      "arn:aws:s3:::rzp-1642-airflow/dags",
      "arn:aws:s3:::rzp-warehouse/config/prod",
      "arn:aws:s3:::rzp-warehouse/config/prod/*",
    ]
  }
}

data "aws_iam_policy_document" "aws_csi_ebs_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:AttachVolume",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteSnapshot",
      "ec2:DeleteTags",
      "ec2:DeleteVolume",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInstances",
      "ec2:DescribeSnapshots",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumesModifications",
      "ec2:DetachVolume",
      "ec2:ModifyVolume",
    ]

    resources = [
      "*",
    ]
  }
}

data aws_iam_policy_document "cloudfront_logs_sumologic_doc" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucketVersions",
      "s3:ListBucket",
      "s3:GetObjectVersion",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-nvirignia-cf-access-logs/*",
      "arn:aws:s3:::rzp-1415-nvirignia-cf-access-logs",
    ]
  }
}


data "aws_iam_policy_document" "cc_address_service_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketLocation",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-checkout/*",
      "arn:aws:s3:::rzp-1415-prod-checkout",
    ]
  }
}

data "aws_iam_policy_document" "ufh_s3_capital_marketplace_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketAcl"
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-capital-marketplace-service/*",
      "arn:aws:s3:::rzp-prod-capital-marketplace-service",
    ]
  }
}


data "aws_iam_policy_document" "shipping_service_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-shipping-service-order-status-update",
      "arn:aws:sqs:ap-south-1:141592612890:prod-shipping-service-order-status-update-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-shipping-service-external-order-poller",
      "arn:aws:sqs:ap-south-1:141592612890:prod-shipping-service-external-order-poller-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-shipping-service-awb-registration",
      "arn:aws:sqs:ap-south-1:141592612890:prod-shipping-service-awb-registration-dlq",
      "arn:aws:sqs:ap-south-1:141592612890:prod-shipping-service-awb-webhook-update",
      "arn:aws:sqs:ap-south-1:141592612890:prod-shipping-service-awb-webhook-update-dlq",
    ]
  }
}

data "aws_iam_policy_document" "ufh_s3_capital_services_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetBucketAcl",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:DeleteObject"
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-capital-los-cir/*",
      "arn:aws:s3:::rzp-1415-prod-capital-los-cir",
      "arn:aws:s3:::rzp-1415-prod-capital-scorecard/*",
      "arn:aws:s3:::rzp-1415-prod-capital-scorecard",
      "arn:aws:s3:::rzp-1415-prod-capital-lender-service/*",
      "arn:aws:s3:::rzp-1415-prod-capital-lender-service",
      "arn:aws:s3:::rzp-1415-prod-capital-collections/*",
      "arn:aws:s3:::rzp-1415-prod-capital-collections",
      "arn:aws:s3:::rzp-1415-prod-capital-collections-recon/*",
      "arn:aws:s3:::rzp-1415-prod-capital-collections-recon"
    ]
  }
}

data "aws_iam_policy_document" "rto_prediction_service_policy_document" {
  statement {
    effect = "Allow"
    sid    = 1

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetBucketAcl",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-rto-prediction-service/*",
      "arn:aws:s3:::rzp-1415-prod-rto-prediction-service",
      "arn:aws:s3:::rzp-1415-prod-rto-merchant-file-uploads",
      "arn:aws:s3:::rzp-1415-prod-rto-merchant-file-uploads/*",
    ]
  }
}

data "aws_iam_policy_document" "address_service_policy_document" {
  statement {
    effect = "Allow"
    sid    = 1

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-address-service-shopify-address-poller",
    ]
  }
}

data "aws_iam_policy_document" "rto_merchant_file_uploads_policy_document" {
  statement {
    effect = "Allow"
    sid    = 1

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetBucketAcl",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-rto-merchant-file-uploads/*",
      "arn:aws:s3:::rzp-1415-prod-rto-merchant-file-uploads"
    ]
  }
}


data "aws_iam_policy_document" "address_standardization_policy_document" {
  statement {
    effect = "Allow"
    sid    = 1

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetBucketAcl",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-address-standardization/*",
      "arn:aws:s3:::rzp-1415-prod-address-standardization/"
    ]
  }
}

# Growth Service
data "aws_iam_policy_document" "growth_service_policy_documents" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-growth-service",
      "arn:aws:s3:::rzp-1415-prod-growth-service/*",
      "arn:aws:s3:::rzp-1415-prod-checkout-live/growth",
      "arn:aws:s3:::rzp-1415-prod-checkout-live/growth/*"
    ]
  }
}

data "aws_iam_role" "gha-prod-frontend_checkout" {
  name = "gha-prod-frontend_checkout"
}

data "aws_iam_policy_document" "checkout-static-prod-invalidate-cloudfront-cache" {
  statement {
    effect = "Allow"
    sid    = 1
    actions = ["cloudfront:CreateInvalidation"]
    resources = [
      "arn:aws:cloudfront::141592612890:distribution/E2RK6LAT9F78JF",
      "arn:aws:cloudfront::141592612890:distribution/E2C4TJ1SGQAY82",
      "arn:aws:cloudfront::141592612890:distribution/E10EFYGUV7S9YQ",
      "arn:aws:cloudfront::141592612890:distribution/E5JSQCVZV2J40"
    ]
  }
}

# custom domain service
data "aws_iam_policy_document" "prod-custom-domain-policy-documents" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-cds-generic-queue",
    ]
  }
}

data "aws_iam_policy_document" "custom_solutions_web_policy_document" {
  statement {
    sid    = 1
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetBucketAcl",
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-csw-custom-reports/*",
      "arn:aws:s3:::rzp-1415-prod-csw-custom-reports",
    ]
  }
}

data "aws_iam_policy_document" "prod-chotabeam-policy-document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-sftp/*",
      "arn:aws:s3:::rzp-1415-prod-sftp",
      "arn:aws:s3:::razorpay-sftp",
      "arn:aws:s3:::razorpay-sftp/*",
      "arn:aws:s3:::rzp-1415-prod-hdfc-collect-now-settlement",
      "arn:aws:s3:::rzp-1415-prod-hdfc-collect-now-settlement/*"
    ]
  }
}

## Subscriptions-dark
data "aws_iam_policy_document" "subscriptions_dark_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:${var.account_id}:key/b08e6ee9-0141-423e-96ea-d2cab9357bc5",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:GetItem",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:${var.account_id}:table/credstash-prod-subscriptions",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-subscriptions-webhook",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-subscriptions-slack",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-subscriptions-payment-notify",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-subscriptions-mail",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-subscriptions-charge",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-subscriptions-upi-charge",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-subscriptions-merchant-risk",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-subscriptions-create-invoice",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-email-templates",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-email-templates/*",
    ]
  }
}

data "aws_iam_policy_document" "prod_capital_los_sqs_policy_documents" {
  statement {
    effect = "Allow"

    actions = ["sqs:*"]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-los-*",
    ]
  }
}

# Capital Scorecard IAM Policy

data "aws_iam_policy_document" "prod_capital_scorecard_sqs_policy_documents" {
  statement {
    effect = "Allow"

    actions = ["sqs:*"]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-los-*",
    ]
  }
}


# Partnerships IAM Policy
data "aws_iam_policy_document" "partnerships_policy_document" {
  statement {
    effect = "Allow"
    sid    = 1

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:${var.environment}-partnerships-commission-capture-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:${var.environment}-partnerships-commission-capture-test"
    ]
  }
}

# no-code-apps service
data "aws_iam_policy_document" "prod-no-code-apps-policy-documents" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-nca-generic-queue",
    ]
  }
}

# consumer app iam policy
data "aws_iam_policy_document" "consumer_app_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:141592612890:prod-magic-checkout-analytics-event-processor",
      "arn:aws:sqs:ap-south-1:141592612890:prod-magic-checkout-analytics-event-processor-dlq",
    ]
  }
}

data "aws_iam_policy_document" "prod_capital_lender_sqs_policy_documents" {
  statement {
    effect = "Allow"

    actions = ["sqs:*"]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-lender-*",
    ]
  }
}

data "aws_iam_policy_document" "prod_capital_loc_sqs_policy_documents" {
  statement {
    effect = "Allow"

    actions = ["sqs:*"]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-loc-*",
    ]
  }
}

data "aws_iam_policy_document" "prod_capital_es_sqs_policy_documents" {
  statement {
    effect = "Allow"

    actions = ["sqs:*"]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-capital-es-*",
    ]
  }
}
