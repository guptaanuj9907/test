
data "aws_iam_role" "eks_cde_blue_worker_kiam" {
  name = "eks-cde-blue-worker-kiam"
}

data "aws_iam_role" "eks_cde_green_worker_kiam" {
  name = "eks-cde-green-worker-kiam"
}

data "aws_iam_role" "eks_card_txzn_blue_worker_kiam" {
  name = "eks-card-txzn-blue-worker-kiam"
}

data "aws_iam_role" "eks_card_txzn_green_worker_kiam" {
  name = "eks-card-txzn-green-worker-kiam"
}

data "aws_iam_policy_document" "services-assume-role" {
  # statement {
  #   effect = "Allow"

  #   actions = [
  #     "sts:AssumeRole",
  #   ]

  #   principals {
  #     type = "AWS"

  #     identifiers = [
  #       "${data.aws_iam_role.cde_white_master.arn}",
  #     ]
  #   }
  # }

  # statement {
  #   effect = "Allow"

  #   actions = [
  #     "sts:AssumeRole",
  #   ]

  #   principals {
  #     type = "AWS"

  #     identifiers = [
  #       "${data.aws_iam_role.cde_green_master.arn}",
  #     ]
  #   }
  # }

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "${data.aws_iam_role.eks_cde_blue_worker_kiam.arn}",
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
        "${data.aws_iam_role.eks_cde_green_worker_kiam.arn}",
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
        "${data.aws_iam_role.eks_card_txzn_blue_worker_kiam.arn}",
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
        "${data.aws_iam_role.eks_card_txzn_green_worker_kiam.arn}",
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

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type = "AWS"

      identifiers = [
        "${data.aws_iam_role.eks_card_txzn_blue_worker_kiam.arn}",
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
        "${data.aws_iam_role.eks_card_txzn_green_worker_kiam.arn}",
      ]
    }
  }
}

# hvault
data "aws_kms_key" "hvault_kms" {
  key_id = "alias/prod-hvault"
}

# vault
data "aws_kms_key" "vault_kms" {
  key_id = "alias/prod-vault"
}

# kubestash
data "aws_dynamodb_table" "kubestash_dynamodb" {
  name = "kubestash-cde"
}

# hvault-mhq
data "aws_kms_key" "hvault_mhq_key" {
  key_id = "alias/prod-hvault-mhq"
}
