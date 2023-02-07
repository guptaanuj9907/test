# hvault
resource "aws_iam_role" "hvault_iam_role" {
  name               = "${var.environment}-hvault"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

module "hvault_credstash_policy_attachment" {
  count            = "1"
  source           = "git@github.com:razorpay/terraform-modules.git//providers//aws//iam-credstash-attachment?ref=v145"
  name             = "${var.environment}-hvault"
  role_name        = ["${aws_iam_role.hvault_iam_role.name}"]
  users            = ["kube-api-prod-hvault"]
  table_name       = "${var.environment}-hvault"
  policy_documents = "${data.aws_iam_policy_document.hvault_policy_document.json}"
}

# payments card iam role
resource "aws_iam_role" "payments_card_iam_role" {
  name               = "${var.environment}-payments-card"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "payments_card_policy" {
  name   = "${var.environment}-payments-card"
  policy = "${data.aws_iam_policy_document.payments_card_policy_document.json}"
}

resource "aws_iam_policy_attachment" "payments_card_policy_document" {
  name       = "${var.environment}-policy-document"
  policy_arn = "${aws_iam_policy.payments_card_policy.arn}"
  roles      = ["${aws_iam_role.payments_card_iam_role.name}"]
}

# barricade iam role
resource "aws_iam_role" "prod_barricade" {
  name               = "${var.environment}-barricade"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod_barricade_policy" {
  name   = "${var.environment}-barricade"
  policy = "${data.aws_iam_policy_document.prod_barricade_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "prod_barricade_attachment" {
  name       = "${var.environment}-barricade"
  policy_arn = "${aws_iam_policy.prod_barricade_policy.arn}"
  roles      = ["${aws_iam_role.prod_barricade.name}"]
}


# mandate-manager card iam role
resource "aws_iam_role" "mandate_manager_iam_role" {
  name               = "${var.environment}-mandate-manager"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "mandate_manager_policy" {
  name   = "${var.environment}-mandate-manager-policy"
  policy = "${data.aws_iam_policy_document.mandate_manager_policy_document.json}"
}

resource "aws_iam_policy_attachment" "mandate_manager_policy_attachment" {
  name       = "${var.environment}-mandate-manager-policy-attachment"
  policy_arn = "${aws_iam_policy.mandate_manager_policy.arn}"
  roles      = ["${aws_iam_role.mandate_manager_iam_role.name}"]
}

resource "aws_iam_role" "mandatehq_issuer_iam_role" {
  name               = "${var.environment}-mandatehq-issuer"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "mandatehq_issuer_policy" {
  name   = "${var.environment}-mandatehq_issuer_policy"
  policy = "${data.aws_iam_policy_document.mandatehq_issuer_policy_document.json}"
}

resource "aws_iam_policy_attachment" "mandatehq_issuer_policy_attachment" {
  name       = "${var.environment}-mandatehq-issuer-policy-attachment"
  policy_arn = "${aws_iam_policy.mandatehq_issuer_policy.arn}"
  roles      = ["${aws_iam_role.mandatehq_issuer_iam_role.name}"]
}


resource "aws_iam_role" "mandatehq_admin_iam_role" {
  name               = "${var.environment}-mandatehq-admin"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "mandatehq_admin_policy" {
  name   = "${var.environment}-mandatehq_admin_policy"
  policy = "${data.aws_iam_policy_document.mandatehq_issuer_policy_document.json}"
}

resource "aws_iam_policy_attachment" "mandatehq_admin_policy_attachment" {
  name       = "${var.environment}-mandatehq-admin-policy-attachment"
  policy_arn = "${aws_iam_policy.mandatehq_admin_policy.arn}"
  roles      = ["${aws_iam_role.mandatehq_admin_iam_role.name}"]
}

# Dark env mandateHQ
resource "aws_iam_role" "dark_mandate_manager_iam_role" {
  name               = "dark-mandate-manager"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "dark_mandate_manager_policy" {
  name   = "dark-mandate-manager-policy"
  policy = "${data.aws_iam_policy_document.dark_mandate_manager_policy_document.json}"
}

resource "aws_iam_policy_attachment" "dark_mandate_manager_policy_attachment" {
  name       = "dark-mandate-manager-policy-attachment"
  policy_arn = "${aws_iam_policy.dark_mandate_manager_policy.arn}"
  roles      = ["${aws_iam_role.dark_mandate_manager_iam_role.name}"]
}

resource "aws_iam_role" "dark_mandatehq_issuer_iam_role" {
  name               = "dark-mandatehq-issuer"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "dark_mandatehq_issuer_policy" {
  name   = "dark-mandatehq_issuer_policy"
  policy = "${data.aws_iam_policy_document.mandatehq_issuer_policy_document.json}"
}

resource "aws_iam_policy_attachment" "dark_mandatehq_issuer_policy_attachment" {
  name       = "dark-mandatehq-issuer-policy-attachment"
  policy_arn = "${aws_iam_policy.dark_mandatehq_issuer_policy.arn}"
  roles      = ["${aws_iam_role.dark_mandatehq_issuer_iam_role.name}"]
}


# payments card dark iam role
resource "aws_iam_role" "payments_card_iam_role_dark" {
  name               = "${var.environment}-payments-card-dark"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "payments_card_policy_dark" {
  name   = "${var.environment}-payments-card-dark"
  policy = "${data.aws_iam_policy_document.payments_card_policy_document_dark.json}"
}

resource "aws_iam_policy_attachment" "payments_card_policy_document_dark" {
  name       = "${var.environment}-policy-document-dark"
  policy_arn = "${aws_iam_policy.payments_card_policy_dark.arn}"
  roles      = ["${aws_iam_role.payments_card_iam_role_dark.name}"]
}

#ClusterAutoscaler IAM Role

resource "aws_iam_role" "clusterautoscaler_iam_role" {
  name               = "${var.environment}-cluster-autoscaler"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "clusterautoscaler_policy" {
  name   = "${var.environment}-clusterautoscaler-policy"
  policy = "${data.aws_iam_policy_document.clusterautoscaler_policy_document.json}"
}

resource "aws_iam_policy_attachment" "clusterautoscaler_policy_document" {
  name       = "${var.environment}-clusterautoscaler-attachment"
  policy_arn = "${aws_iam_policy.clusterautoscaler_policy.arn}"
  roles      = ["${aws_iam_role.clusterautoscaler_iam_role.name}"]
}

# Payments NBplus
# resource "aws_iam_role" "payments_nbplus_iam_role" {
#   name               = "${var.environment}-payments-nbplus"
#   assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
# }

# resource "aws_iam_policy" "payments_nbplus_policy" {
#   name   = "${var.environment}-payments-nbplus-policy"
#   policy = "${data.aws_iam_policy_document.payments_nbplus_policy_documents.json}"
# }

# resource "aws_iam_policy_attachment" "payments_nbplus_policy_document" {
#   name       = "${var.environment}-payments-nbplus-attachment"
#   policy_arn = "${aws_iam_policy.payments_nbplus_policy.arn}"
#   roles      = ["${aws_iam_role.payments_nbplus_iam_role.name}"]
# }

# Payments NBplus dark
# resource "aws_iam_role" "payments_nbplus_iam_role_dark" {
#   name               = "${var.environment}-payments-nbplus-dark"
#   assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
# }

# resource "aws_iam_policy" "payments_nbplus_policy_dark" {
#   name   = "${var.environment}-payments-nbplus-policy-dark"
#   policy = "${data.aws_iam_policy_document.payments_nbplus_policy_documents_dark.json}"
# }

# resource "aws_iam_policy_attachment" "payments_nbplus_policy_document_dark" {
#   name       = "${var.environment}-payments-nbplus-attachment-dark"
#   policy_arn = "${aws_iam_policy.payments_nbplus_policy_dark.arn}"
#   roles      = ["${aws_iam_role.payments_nbplus_iam_role_dark.name}"]
# }

# terminals iam role
resource "aws_iam_role" "terminals_iam_role" {
  name               = "${var.environment}-terminals"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "terminals_policy" {
  name   = "${var.environment}-terminals-policy"
  policy = "${data.aws_iam_policy_document.terminals_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "terminals_policy_attachment" {
  name       = "${var.environment}-terminals-policy-attachment"
  policy_arn = "${aws_iam_policy.terminals_policy.arn}"
  roles      = ["${aws_iam_role.terminals_iam_role.name}"]
}

# terminals dark iam role
resource "aws_iam_role" "terminals_dark_iam_role" {
  name               = "${var.environment}-terminals-dark"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "terminals_dark_policy" {
  name   = "${var.environment}-terminals-dark-policy"
  policy = "${data.aws_iam_policy_document.terminals_dark_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "terminals_dark_policy_attachment" {
  name       = "${var.environment}-terminals-dark-policy-attachment"
  policy_arn = "${aws_iam_policy.terminals_dark_policy.arn}"
  roles      = ["${aws_iam_role.terminals_dark_iam_role.name}"]
}

# Vault
resource "aws_iam_role" "vault_iam_role" {
  name               = "${var.environment}-vault"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

module "vault_credstash_policy_attachment" {
  count           = "1"
  source          = "git@github.com:razorpay/terraform-modules.git//providers//aws//iam-credstash-attachment?ref=v250"
  name            = "${var.environment}-vault"
  role_name       = ["${aws_iam_role.vault_iam_role.name}"]
  users           = ["kube-prod-vault"]
  table_name      = "credstash-prod-vault"
  aws_account_no  = "${var.account_id}"
  default_kms_arn = "${var.default_kms_arn}"
}

resource "aws_iam_policy" "kms_vault_policy" {
  name   = "${var.environment}-kms-vault"
  policy = "${data.aws_iam_policy_document.vault_kms_policy_document.json}"
}

resource "aws_iam_policy_attachment" "kms_vault_policy_attach" {
  name       = "${var.environment}-kms-vault-attach"
  policy_arn = "${aws_iam_policy.kms_vault_policy.arn}"
  roles      = ["${aws_iam_role.vault_iam_role.name}"]
}

# sqs autoscaler iam role
resource "aws_iam_role" "autoscaler_iam_role" {
  name               = "${var.environment}-autoscaler"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "autoscaler_policy" {
  name   = "${var.environment}-autoscaler-policy"
  policy = "${data.aws_iam_policy_document.autoscaler_sqs_policy.json}"
}

resource "aws_iam_policy_attachment" "autoscaler_policy_attachment" {
  name       = "${var.environment}-autoscaler-policy-attachment"
  policy_arn = "${aws_iam_policy.autoscaler_policy.arn}"
  roles      = ["${aws_iam_role.autoscaler_iam_role.name}"]
}

# kubestash
resource "aws_iam_role" "kubestash_iam_role" {
  name               = "${var.environment}-kubestash"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

module "kubestash_credstash_policy_attachment" {
  count            = "1"
  source           = "git@github.com:razorpay/terraform-modules.git//providers//aws//iam-credstash-attachment?ref=v181"
  name             = "${var.environment}-kubestash"
  role_name        = ["${aws_iam_role.kubestash_iam_role.name}"]
  table_name       = "kubestashh-cde"
  policy_documents = "${data.aws_iam_policy_document.kubestash_policy_document.json}"
}

# datahub-iam role

resource "aws_iam_role" "datahub_iam_role" {
  name               = "${var.environment}-datahub"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

module "datahub_credstash_policy_attachment" {
  count           = "1"
  source          = "git@github.com:razorpay/terraform-modules.git//providers//aws//iam-credstash-attachment?ref=v250"
  name            = "${var.environment}-datahub"
  role_name       = ["${aws_iam_role.datahub_iam_role.name}"]
  table_name      = "credstash-prod-datahub"
  aws_account_no  = "${var.account_id}"
  default_kms_arn = "${var.default_kms_arn}"
}

resource "aws_iam_role" "sqs_autoscaler" {
  name  = "${var.environment}-sqs-autoscaler"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "sqs_autoscaler_policy" {
  name        = "${var.environment}-sqs-autoscaler-policy"
  path        = "/"
  policy      = "${data.aws_iam_policy_document.sqs_autoscaler_policy_document.json}"
}

resource "aws_iam_policy_attachment" "sqs_autoscaler_policy_attachment" {
  name       = "${var.environment}-sqs-autoscaler-attachment"
  policy_arn = "${aws_iam_policy.sqs_autoscaler_policy.arn}"
  roles      = ["${aws_iam_role.sqs_autoscaler.name}"]
}

resource "aws_iam_role" "cde_kubestash_iam_role" {
  name               = "cde-kubestash"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

module "cde_kubestash_credstash_policy_attachment" {
  source           = "git@github.com:razorpay/terraform-modules.git//providers//aws//iam-credstash-attachment?ref=v181"
  name             = "cde-kubestash"
  role_name        = ["${aws_iam_role.cde_kubestash_iam_role.name}"]
  table_name       = "kubestash-cde"
  policy_documents = "${data.aws_iam_policy_document.cde_kubestash_policy_document.json}"
}

# hvault-mhq
resource "aws_iam_role" "hvault_mhq_iam_role" {
  name               = "${var.environment}-hvault-mhq"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "hvault_mhq_policy" {
  name   = "${var.environment}-hvault-mhq-policy"
  policy = "${data.aws_iam_policy_document.hvault_mhq_policy_document.json}"
}

module "hvault_mhq_credstash_policy_attachment" {
  count            = "1"
  source           = "git@github.com:razorpay/terraform-modules.git//providers//aws//iam-credstash-attachment?ref=v145"
  name             = "${var.environment}-hvault-mhq"
  role_name        = ["${aws_iam_role.hvault_mhq_iam_role.name}"]
  users            = ["kube-api-prod-hvault-mhq"]
  table_name       = "${var.environment}-hvault-mhq"
  policy_documents = "${data.aws_iam_policy_document.hvault_mhq_policy_document.json}"
}

#policy attachement mandatehq
resource "aws_iam_policy_attachment" "mandatehq-access" {
  name       = "mandatehq-access-static-files"
  users      = ["${aws_iam_user.mandatehq.name}"]
  policy_arn = "${aws_iam_policy.mandatehq-access-policy.arn}"
}

resource "aws_iam_policy" "mandatehq-access-policy" {
  name   = "mandatehq-access-policy"
  policy = "${data.aws_iam_policy_document.mandatehq-access.json}"
}

# Payouts service iam role
resource "aws_iam_role" "payouts_iam_role" {
  name               = "${var.environment}-payouts"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "payouts_policy" {
  name   = "${var.environment}-payouts-policy"
  policy = "${data.aws_iam_policy_document.payouts_policy_document.json}"
}

resource "aws_iam_policy_attachment" "payouts_policy_attachment" {
  name       = "${var.environment}-payouts-policy-attachment"
  policy_arn = "${aws_iam_policy.payouts_policy.arn}"
  roles      = ["${aws_iam_role.payouts_iam_role.name}"]
}

