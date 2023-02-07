# hvault iam policy

data "aws_iam_policy_document" "hvault_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:DescribeKey",
    ]

    resources = [
      "${data.aws_kms_key.hvault_kms.arn}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:ListTagsOfResource",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:ListTables",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:Scan",
      "dynamodb:DescribeTable",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:${var.account_id}:table/prod-hvault",
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

# payments card
data "aws_iam_policy_document" "payments_card_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payments-card-api-reconciliation-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payments-card-api-reconciliation-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-barricade-verify",
    ]
  }
}

# barricade
data "aws_iam_policy_document" "prod_barricade_policy_documents" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-barricade-verify",
    ]
  }
}

# mandateHQ

data "aws_iam_policy_document" "mandate_manager_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
      "es:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-mandate-manager-notifications",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-mandate-manager-webhooks",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-mandate-manager-reports",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-mandate-manager-external-webhooks",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-mandate-manager-es",
      "arn:aws:es:ap-south-1:141592612890:domain/prod-mandatehq-es",
    ]
  }
}

data "aws_iam_policy_document" "mandatehq_issuer_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "es:*",
      "s3:PutObjectAcl",
      "s3:PutObject",
      "s3:ListBucket",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:GetBucketAcl",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:es:ap-south-1:141592612890:domain/prod-mandatehq-es",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-test-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-test-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-oc-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-oc-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-equitas-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-equitas-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-hsbc-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-hsbc-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-kvb-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-kvb-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-icici-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-icici-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-cu-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-cu-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-slice-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-slice-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-pnb-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-pnb-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-indian-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-indian-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-maha-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-maha-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-razorpayx-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-razorpayx-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-iob-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-iob-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-axis-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-axis-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-jupiter-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-jupiter-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-niyopay-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-niyopay-issuer-reports/*",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-psb-issuer-reports",
      "arn:aws:s3:::rzp-1415-prod-mandatehq-psb-issuer-reports/*",
    ]
  }
}

# mandateHQ Dark
data "aws_iam_policy_document" "dark_mandate_manager_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
      "es:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-mandate-manager-notifications",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-mandate-manager-webhooks",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-mandate-manager-reports",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-mandate-manager-external-webhooks",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-mandate-manager-es",
      "arn:aws:es:ap-south-1:141592612890:domain/prod-mandatehq-es",
    ]
  }
}

# payments card dark

data "aws_iam_policy_document" "payments_card_policy_document_dark" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-payments-card-api-reconciliation-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:dark-payments-card-api-reconciliation-live",
    ]
  }
}

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
    ]
  }
}

# Terminals iam policy
data "aws_iam_policy_document" "terminals_policy_documents" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    // add the api sqs here.
    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-terminals-synchronize",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-terminals-testsuite",
    ]
  }
}

# Terminals dark iam policy
data "aws_iam_policy_document" "terminals_dark_policy_documents" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
    ]

    // add the api sqs here.
    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-terminals-synchronize",
    ]
  }
}

# vault iam policy
data "aws_iam_policy_document" "vault_kms_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:DescribeKey",
    ]

    resources = [
      "${data.aws_kms_key.vault_kms.arn}",
    ]
  }
}

# sqs autoscaler iam policy
data "aws_iam_policy_document" "autoscaler_sqs_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:ListQueues",
      "sqs:GetQueueAttributes",
    ]

    resources = [
      "*",
    ]
  }
}

#kubestash iam policy

data "aws_iam_policy_document" "kubestash_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/e8a26ac9-1314-41bf-aa6f-c963c519899a",
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
      "${data.aws_dynamodb_table.kubestash_dynamodb.arn}",
    ]
  }
}

#hvault-mhq iam
data "aws_iam_policy_document" "hvault_mhq_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:DescribeKey",
    ]

    resources = [
      "${data.aws_kms_key.hvault_mhq_key.arn}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:ListTagsOfResource",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:ListTables",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:Scan",
      "dynamodb:DescribeTable",
    ]

    resources = [
      "arn:aws:dynamodb:ap-south-1:${var.account_id}:table/prod-hvault-mhq",
    ]
  }
}

#mandatehq user policy

data "aws_iam_policy_document" "mandatehq-access" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
      "cloudfront:*",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-prod-mandate-hq/*",
      "arn:aws:s3:::rzp-1415-prod-mandate-hq",
      "arn:aws:cloudfront::${var.account_id}:distribution/ETAZD45KCHSM2",
    ]
  }
}

# Payouts service
data "aws_iam_policy_document" "payouts_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:*",
      "s3:PutObject",
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-transaction-create-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-transaction-create-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-queued-processing-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-queued-processing-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-schedule-processing-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-schedule-processing-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-on-hold-processing-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-on-hold-processing-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-data-consistency-event-processing-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-data-consistency-event-processing-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-data-consistency-checker-processing-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-data-consistency-checker-processing-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-api-payout-source-updater-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-api-payout-source-updater-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-payout-create-failure-handling-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-payout-create-failure-handling-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-payout-update-failure-handling-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-payout-update-failure-handling-test",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-async-dual-write-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-batch-submitted-merchants-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-bulk-payouts-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-webhook-event-live",
      "arn:aws:sqs:ap-south-1:${var.account_id}:prod-payouts-webhook-event-test",
      "arn:aws:s3:::rzp-1415-prod-payout-attachments/*",
    ]
  }
}

data "aws_dynamodb_table" "cde_kubestash_dynamodb" {
  name = "kubestash-cde"
}

data "aws_iam_policy_document" "cde_kubestash_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "kms:Decrypt",
    ]

    resources = [
      "arn:aws:kms:ap-south-1:141592612890:key/e8a26ac9-1314-41bf-aa6f-c963c519899a",
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
      "${data.aws_dynamodb_table.cde_kubestash_dynamodb.arn}",
    ]
  }
}

data "aws_iam_policy_document" "sqs_autoscaler_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:ListQueues",
      "sqs:GetQueueAttributes"
    ]

    resources = ["*"]
  }
}
