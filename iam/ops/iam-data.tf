# harbor
data "aws_iam_policy_document" "harbor_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-harbor-registry/*",
      "arn:aws:s3:::rzp-prod-harbor-registry",
    ]
  }
}

data "aws_iam_policy_document" "cloudwatch-exporter-policy" {
  statement {
    effect = "Allow"

    actions = [
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "tag:GetResources",
    ]

    resources = [
      "*",
    ]
  }
}

# RDSLogs
data "aws_iam_policy_document" "rdslogs_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "rds:DownloadDBLogFilePortion",
      "rds:DescribeDBLogFiles",
      "rds:DescribeDBInstances",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "github-actions-prod-mandate-manager-fe-policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:DeleteObject",
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-mandate-manager-fe/*",
      "arn:aws:s3:::rzp-prod-mandate-manager-fe",
      "arn:aws:s3:::rzp-actions-cache/*",
      "arn:aws:s3:::rzp-actions-cache",
    ]
  }
}


data "aws_iam_policy_document" "lambda-assume-role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "lambda.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "rds_sumologic_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
      "logs:Get*"
    ]

    resources = [
      "*",
    ]
  }
}
# BAD-7749 waf-automation

data "aws_iam_policy_document" "waf_policy_document" {
  statement {
    effect = "Allow"
    sid    = 1

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-security-alerts/*",
      "arn:aws:s3:::rzp-prod-security-alerts"
    ]
  }

  statement {
    effect = "Allow"
    sid    = 2

    actions = [
      "wafv2:DeleteIPSet",
      "wafv2:GetIPSet",
      "wafv2:ListIPSets",
      "wafv2:UpdateIPSet",
      "wafv2:CreateIPSet"
      ]

    resources = [
      "*"
    ]
  }
}

# Terraform Registry (Citizen)
data "aws_iam_policy_document" "tfregistry_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::rzp-1415-ops-terraform-registry/*",
      "arn:aws:s3:::rzp-1415-ops-terraform-registry",
    ]
  }
}

# cur refresher
data "aws_iam_policy_document" "cur_refresher_policy_document" {
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
      "s3:GetObjectTagging",
      "s3:PutObjectTagging"
    ]

    resources = [
      "arn:aws:s3:::rzp-cur/*",
      "arn:aws:s3:::rzp-cur",
    ]
  }
}

data "aws_iam_policy_document" "security_cartography_service" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = [
      "arn:aws:iam::*:role/security-tools-cartography-read-only"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ec2:DescribeRegions",
    ]

    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::rzp-prod-security-alerts/*"
    ]
  }
}

