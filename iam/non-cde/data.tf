data "aws_iam_role" "prod_white_master" {
  name = "prod-white-master"
}

data "aws_iam_role" "prod_blue_master" {
  name = "prod-blue-master"
}

data "aws_iam_role" "prod_green_worker_kiam" {
  name = "eks-prod-green-worker-kiam"
}

data "aws_iam_role" "prod_white_worker_kiam" {
  name = "eks-prod-white-worker-kiam"
}
data "aws_iam_policy_document" "services-assume-role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "${data.aws_iam_role.prod_white_master.arn}",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "${data.aws_iam_role.prod_blue_master.arn}",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "${data.aws_iam_role.prod_green_worker_kiam.arn}",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "${data.aws_iam_role.prod_white_worker_kiam.arn}",
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "Service"

      identifiers = [
        "ec2.amazonaws.com",
      ]
    }
  }
}

data "aws_iam_policy_document" "sumologic_cloudfront_logs_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "arn:aws:iam::926226587429:root", // sumologic india account
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        "in:0000000000000023",
      ]
    }
  }
}
