data "aws_iam_role" "eks-ops-common-worker-kiam" {
  name = "eks-ops-common-worker-kiam"
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
        "${data.aws_iam_role.eks-ops-common-worker-kiam.arn}",
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

data "aws_iam_policy" "security_audit" {
  arn = "arn:aws:iam::aws:policy/SecurityAudit"
}