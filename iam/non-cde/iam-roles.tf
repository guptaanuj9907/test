# Payments NBplus
resource "aws_iam_role" "payments_nbplus_iam_role" {
  name               = "${var.environment}-payments-nbplus"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "payments_nbplus_policy" {
  name   = "${var.environment}-payments-nbplus-policy"
  policy = "${data.aws_iam_policy_document.payments_nbplus_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "payments_nbplus_policy_document" {
  name       = "${var.environment}-payments-nbplus-attachment"
  policy_arn = "${aws_iam_policy.payments_nbplus_policy.arn}"
  roles      = ["${aws_iam_role.payments_nbplus_iam_role.name}"]
}

# Payments NBplus dark
resource "aws_iam_role" "payments_nbplus_iam_role_dark" {
  name               = "${var.environment}-payments-nbplus-dark"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "payments_nbplus_policy_dark" {
  name   = "${var.environment}-payments-nbplus-policy-dark"
  policy = "${data.aws_iam_policy_document.payments_nbplus_policy_documents_dark.json}"
}

resource "aws_iam_policy_attachment" "payments_nbplus_policy_document_dark" {
  name       = "${var.environment}-payments-nbplus-attachment-dark"
  policy_arn = "${aws_iam_policy.payments_nbplus_policy_dark.arn}"
  roles      = ["${aws_iam_role.payments_nbplus_iam_role_dark.name}"]
}

#Vendor_payments IAM role
resource "aws_iam_role" "vendor_payments_iam_role" {
  name               = "${var.environment}-vendor-payments"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "vendor_payments_policy" {
  name   = "${var.environment}-vendor-payments-policy"
  policy = "${data.aws_iam_policy_document.vendor_payments_policy_document.json}"
}

resource "aws_iam_policy_attachment" "vendor_payments_policy_document" {
  name       = "${var.environment}-vendor-payments-attachment"
  policy_arn = "${aws_iam_policy.vendor_payments_policy.arn}"
  roles      = ["${aws_iam_role.vendor_payments_iam_role.name}"]
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

# razorx IAM Role
resource "aws_iam_role" "razorx_iam_role" {
  name               = "${var.environment}-razorx"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "razorx_policy" {
  name   = "${var.environment}-razorx-policy"
  policy = "${data.aws_iam_policy_document.razorx_policy_document.json}"
}

resource "aws_iam_policy_attachment" "razorx_policy_document" {
  name       = "${var.environment}-razorx-attachment"
  policy_arn = "${aws_iam_policy.razorx_policy.arn}"
  roles      = ["${aws_iam_role.razorx_iam_role.name}"]
}

#batch IAM Role
resource "aws_iam_role" "batch_iam_role" {
  name               = "${var.environment}-batch"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "batch_policy" {
  name   = "${var.environment}-batch-policy"
  policy = "${data.aws_iam_policy_document.batch_policy_document.json}"
}

resource "aws_iam_policy_attachment" "batch_policy_document" {
  name       = "${var.environment}-batch-attachment"
  policy_arn = "${aws_iam_policy.batch_policy.arn}"
  roles      = ["${aws_iam_role.batch_iam_role.name}"]
}

#Credstash-ui IAM Role
resource "aws_iam_role" "credstash_ui_iam_role" {
  name               = "${var.environment}-credstash-ui"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "credstash_ui_policy" {
  name   = "${var.environment}-credstash-ui-policy"
  policy = "${data.aws_iam_policy_document.credstash_ui_policy_document.json}"
}

resource "aws_iam_policy_attachment" "credstash_ui_policy_document" {
  name       = "${var.environment}-credstash-ui-attachment"
  policy_arn = "${aws_iam_policy.credstash_ui_policy.arn}"
  roles      = ["${aws_iam_role.credstash_ui_iam_role.name}"]
}

#Doppler IAM Role
resource "aws_iam_role" "doppler_iam_role" {
  name               = "${var.environment}-doppler"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "doppler_policy" {
  name   = "${var.environment}-doppler-policy"
  policy = "${data.aws_iam_policy_document.doppler_policy_document.json}"
}

resource "aws_iam_policy_attachment" "doppler_policy_document" {
  name       = "${var.environment}-doppler-attachment"
  policy_arn = "${aws_iam_policy.doppler_policy.arn}"
  roles      = ["${aws_iam_role.doppler_iam_role.name}"]
}

#Entity-processor IAM Role
resource "aws_iam_role" "entity_processor_iam_role" {
  name               = "${var.environment}-entity-processor"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "entity_processor_policy" {
  name   = "${var.environment}-entity-processor-policy"
  policy = "${data.aws_iam_policy_document.entity_processor_policy_document.json}"
}

resource "aws_iam_policy_attachment" "entity_processor_policy_document" {
  name       = "${var.environment}-entity-processor-attachment"
  policy_arn = "${aws_iam_policy.entity_processor_policy.arn}"
  roles      = ["${aws_iam_role.entity_processor_iam_role.name}"]
}

#events-stream IAM Role
resource "aws_iam_role" "events_stream_iam_role" {
  name               = "${var.environment}-events-stream"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "events_stream_policy" {
  name   = "${var.environment}-events-stream-policy"
  policy = "${data.aws_iam_policy_document.events_stream_policy_document.json}"
}

resource "aws_iam_policy_attachment" "events_stream_policy_document" {
  name       = "${var.environment}-events-stream-attachment"
  policy_arn = "${aws_iam_policy.events_stream_policy.arn}"
  roles      = ["${aws_iam_role.events_stream_iam_role.name}"]
}

#financial_data_service IAM Role
resource "aws_iam_role" "financial_data_service_iam_role" {
  name               = "${var.environment}-financial-data-service"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "financial_data_service_policy" {
  name   = "${var.environment}-financial-data-service-policy"
  policy = "${data.aws_iam_policy_document.financial_data_service_policy_document.json}"
}

resource "aws_iam_policy_attachment" "financial_data_service_policy_document" {
  name       = "${var.environment}-financial-data-service-attachment"
  policy_arn = "${aws_iam_policy.financial_data_service_policy.arn}"
  roles      = ["${aws_iam_role.financial_data_service_iam_role.name}"]
}

#fts IAM Role
resource "aws_iam_role" "fts_iam_role" {
  name               = "${var.environment}-fts"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "fts_policy" {
  name   = "${var.environment}-fts-policy"
  policy = "${data.aws_iam_policy_document.fts_policy_document.json}"
}

resource "aws_iam_policy" "fts_s3_policy" {
  name   = "${var.environment}-fts-s3-policy"
  policy = "${data.aws_iam_policy_document.fts_s3_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "fts_policy_document" {
  policy_arn = "${aws_iam_policy.fts_policy.arn}"
  role       = "${aws_iam_role.fts_iam_role.name}"
}

resource "aws_iam_role_policy_attachment" "fts_s3_policy_document" {
  policy_arn = "${aws_iam_policy.fts_s3_policy.arn}"
  role       = "${aws_iam_role.fts_iam_role.name}"
}

#fts-dark IAM Role
resource "aws_iam_role" "fts_dark_iam_role" {
  name               = "${var.environment}-fts-dark"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "fts_dark_policy" {
  name   = "${var.environment}-fts-dark-policy"
  policy = "${data.aws_iam_policy_document.fts_dark_policy_document.json}"
}

resource "aws_iam_policy" "fts_dark_s3_policy" {
  name   = "${var.environment}-fts-dark-s3-policy"
  policy = "${data.aws_iam_policy_document.fts_dark_s3_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "fts_dark_policy_document" {
  policy_arn = "${aws_iam_policy.fts_dark_policy.arn}"
  role       = "${aws_iam_role.fts_dark_iam_role.name}"
}

resource "aws_iam_role_policy_attachment" "fts_dark_s3_policy_document" {
  policy_arn = "${aws_iam_policy.fts_dark_s3_policy.arn}"
  role       = "${aws_iam_role.fts_dark_iam_role.name}"
}

#ifsc IAM Role
resource "aws_iam_role" "ifsc_iam_role" {
  name               = "${var.environment}-ifsc"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "ifsc_policy" {
  name   = "${var.environment}-ifsc-policy"
  policy = "${data.aws_iam_policy_document.ifsc_policy_document.json}"
}

resource "aws_iam_policy_attachment" "ifsc_policy_document" {
  name       = "${var.environment}-ifsc-attachment"
  policy_arn = "${aws_iam_policy.ifsc_policy.arn}"
  roles      = ["${aws_iam_role.ifsc_iam_role.name}"]
}

#kubestash IAM Role
resource "aws_iam_role" "kubestash_iam_role" {
  name               = "${var.environment}-kubestash"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "kubestash_policy" {
  name   = "${var.environment}-kubestash-policy"
  policy = "${data.aws_iam_policy_document.kubestash_policy_document.json}"
}

resource "aws_iam_policy_attachment" "kubestash_policy_document" {
  name       = "${var.environment}-kubestash-attachment"
  policy_arn = "${aws_iam_policy.kubestash_policy.arn}"
  roles      = ["${aws_iam_role.kubestash_iam_role.name}"]
}

#kyc IAM Role
resource "aws_iam_role" "kyc_iam_role" {
  name               = "${var.environment}-kyc"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "kyc_policy" {
  name   = "${var.environment}-kyc-policy"
  policy = "${data.aws_iam_policy_document.kyc_policy_document.json}"
}

resource "aws_iam_policy_attachment" "kyc_policy_document" {
  name       = "${var.environment}-kyc-attachment"
  policy_arn = "${aws_iam_policy.kyc_policy.arn}"
  roles      = ["${aws_iam_role.kyc_iam_role.name}"]
}

#offline_verification
resource "aws_iam_role" "offline_verification_iam_role" {
  name               = "${var.environment}-offline-verification"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "offline_verification_policy" {
  name   = "${var.environment}-offline-verification-policy"
  policy = "${data.aws_iam_policy_document.offline_verification_policy_document.json}"
}

resource "aws_iam_policy_attachment" "offline_verification_policy_document" {
  name       = "${var.environment}-offline-verification-attachment"
  policy_arn = "${aws_iam_policy.offline_verification_policy.arn}"
  roles      = ["${aws_iam_role.offline_verification_iam_role.name}"]
}

#outline
resource "aws_iam_role" "outline_iam_role" {
  name               = "${var.environment}-outline"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "outline_policy" {
  name   = "${var.environment}-outline-policy"
  policy = "${data.aws_iam_policy_document.outline_policy_document.json}"
}

resource "aws_iam_policy_attachment" "outline_policy_document" {
  name       = "${var.environment}-outline-attachment"
  policy_arn = "${aws_iam_policy.outline_policy.arn}"
  roles      = ["${aws_iam_role.outline_iam_role.name}"]
}

#payment-links IAM Role
resource "aws_iam_role" "payment_links_iam_role" {
  name               = "${var.environment}-payment-links"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "payment_links_policy" {
  name   = "${var.environment}-payment-links-policy"
  policy = "${data.aws_iam_policy_document.payment_links_policy_document.json}"
}

resource "aws_iam_policy_attachment" "payment_links_policy_document" {
  name       = "${var.environment}-payment-links-attachment"
  policy_arn = "${aws_iam_policy.payment_links_policy.arn}"
  roles      = ["${aws_iam_role.payment_links_iam_role.name}"]
}

#payout-links IAM Role
resource "aws_iam_role" "payout_links_iam_role" {
  name               = "${var.environment}-payout-links"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "payout_links_policy" {
  name   = "${var.environment}-payout-links-policy"
  policy = "${data.aws_iam_policy_document.payout_links_policy_document.json}"
}

resource "aws_iam_policy_attachment" "payout_links_policy_document" {
  name       = "${var.environment}-payout-links-attachment"
  policy_arn = "${aws_iam_policy.payout_links_policy.arn}"
  roles      = ["${aws_iam_role.payout_links_iam_role.name}"]
}

#rds-snapshot
resource "aws_iam_role" "rds_snapshot_iam_role" {
  name               = "${var.environment}-rds-snapshot"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "rds_snapshot_policy" {
  name   = "${var.environment}-rds-snapshot-policy"
  policy = "${data.aws_iam_policy_document.rds_snapshot_policy_document.json}"
}

resource "aws_iam_policy_attachment" "rds_snapshot_policy_document" {
  name       = "${var.environment}-rds-snapshot-attachment"
  policy_arn = "${aws_iam_policy.rds_snapshot_policy.arn}"
  roles      = ["${aws_iam_role.rds_snapshot_iam_role.name}"]
}

#recon IAM Role
resource "aws_iam_role" "recon_iam_role" {
  name               = "${var.environment}-recon"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "recon_policy" {
  name   = "${var.environment}-recon-policy"
  policy = "${data.aws_iam_policy_document.recon_policy_document.json}"
}

resource "aws_iam_policy_attachment" "recon_policy_document" {
  name       = "${var.environment}-recon-attachment"
  policy_arn = "${aws_iam_policy.recon_policy.arn}"
  roles      = ["${aws_iam_role.recon_iam_role.name}"]
}

#report-studio
resource "aws_iam_role" "report_studio_iam_role" {
  name               = "${var.environment}-report-studio"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "report_studio_policy" {
  name   = "${var.environment}-report-studio-policy"
  policy = "${data.aws_iam_policy_document.report_studio_policy_document.json}"
}

resource "aws_iam_policy_attachment" "report_studio_policy_document" {
  name       = "${var.environment}-report-studio-attachment"
  policy_arn = "${aws_iam_policy.report_studio_policy.arn}"
  roles      = ["${aws_iam_role.report_studio_iam_role.name}"]
}

#scrooge-dark
resource "aws_iam_role" "scrooge_dark_iam_role" {
  name               = "${var.environment}-scrooge-dark"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "scrooge_dark_policy" {
  name   = "${var.environment}-scrooge-dark-policy"
  policy = "${data.aws_iam_policy_document.scrooge_dark_policy_document.json}"
}

resource "aws_iam_policy_attachment" "scrooge_dark_policy_document" {
  name       = "${var.environment}-scrooge-dark-attachment"
  policy_arn = "${aws_iam_policy.scrooge_dark_policy.arn}"
  roles      = ["${aws_iam_role.scrooge_dark_iam_role.name}"]
}

#stork
resource "aws_iam_role" "stork_iam_role" {
  name               = "${var.environment}-stork"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "stork_policy" {
  name   = "${var.environment}-stork-policy"
  policy = "${data.aws_iam_policy_document.stork_policy_document.json}"
}

resource "aws_iam_policy_attachment" "stork_policy_document" {
  name       = "${var.environment}-stork-attachment"
  policy_arn = "${aws_iam_policy.stork_policy.arn}"
  roles      = ["${aws_iam_role.stork_iam_role.name}"]
}

#verdaccio
resource "aws_iam_role" "verdaccio_iam_role" {
  name               = "${var.environment}-verdaccio"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "verdaccio_policy" {
  name   = "${var.environment}-verdaccio-policy"
  policy = "${data.aws_iam_policy_document.verdaccio_policy_document.json}"
}

resource "aws_iam_policy_attachment" "verdaccio_policy_document" {
  name       = "${var.environment}-verdaccio-attachment"
  policy_arn = "${aws_iam_policy.verdaccio_policy.arn}"
  roles      = ["${aws_iam_role.verdaccio_iam_role.name}"]
}

#atlantis
resource "aws_iam_role" "atlantis_iam_role" {
  name               = "${var.environment}-atlantis"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "atlantis_policy" {
  name   = "${var.environment}-atlantis-policy"
  policy = "${data.aws_iam_policy_document.atlantis_policy_document.json}"
}

resource "aws_iam_policy_attachment" "atlantis_policy_document" {
  name       = "${var.environment}-atlantis-attachment"
  policy_arn = "${aws_iam_policy.atlantis_policy.arn}"
  roles      = ["${aws_iam_role.atlantis_iam_role.name}"]
}

# Reporting IAM roles and policy

resource "aws_iam_role" "reporting_iam_role" {
  name               = "${var.environment}-reporting"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "reporting_policy" {
  name   = "${var.environment}-reporting-policy"
  policy = "${data.aws_iam_policy_document.reporting_policy_document.json}"
}

resource "aws_iam_policy_attachment" "reporting_policy_attach" {
  name       = "${var.environment}-reporting-attachment"
  policy_arn = "${aws_iam_policy.reporting_policy.arn}"
  roles      = ["${aws_iam_role.reporting_iam_role.name}"]
}

# Adding S3 permissions to Reporting IAM role
resource "aws_iam_policy" "reporting_s3_policy" {
  name   = "${var.environment}-reporting-s3-policy"
  policy = "${data.aws_iam_policy_document.reporting-s3-policy-documents.json}"
}

resource "aws_iam_policy_attachment" "reporting_s3_policy_attachment" {
  name       = "${var.environment}-reporting-s3-policy-attachment"
  policy_arn = "${aws_iam_policy.reporting_s3_policy.arn}"
  roles      = ["${aws_iam_role.reporting_iam_role.name}"]
}

# Settlements

resource "aws_iam_role" "settlements_iam_role" {
  name               = "${var.environment}-settlements"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "settlements_policy" {
  name   = "${var.environment}-settlements-policy"
  policy = "${data.aws_iam_policy_document.settlements_policy_document.json}"
}

resource "aws_iam_policy_attachment" "settlements_policy_document" {
  name       = "${var.environment}-settlements-attachment"
  policy_arn = "${aws_iam_policy.settlements_policy.arn}"
  roles      = ["${aws_iam_role.settlements_iam_role.name}"]
}

# IAM role capital-cards
resource "aws_iam_role" "prod_capital_cards_iam_role" {
  name               = "${var.environment}-capital-cards"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod_capital_cards_policy" {
  name   = "${var.environment}-capital-cards-policy"
  policy = "${data.aws_iam_policy_document.prod_capital_cards_policy_document.json}"
}

resource "aws_iam_policy_attachment" "prod_capital_cards_policy_attachment" {
  name       = "${var.environment}-capital-cards-policy-attachment"
  policy_arn = "${aws_iam_policy.prod_capital_cards_policy.arn}"
  roles      = ["${aws_iam_role.prod_capital_cards_iam_role.name}"]
}

# IAM role capital-collections & policies
resource "aws_iam_role" "prod_capital_collections_iam_role" {
  name               = "${var.environment}-capital-collections"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod_capital_collections_policy" {
  name   = "${var.environment}-capital-collections-policy"
  policy = "${data.aws_iam_policy_document.prod_capital_collections_policy_document.json}"
}

resource "aws_iam_policy_attachment" "prod_capital_collections_policy_attachment" {
  name       = "${var.environment}-capital-collections-policy-attachment"
  policy_arn = "${aws_iam_policy.prod_capital_collections_policy.arn}"
  roles      = ["${aws_iam_role.prod_capital_collections_iam_role.name}"]
}

# Subscriptions IAM roles and policies
resource "aws_iam_role" "subscriptions_iam_role" {
  name               = "${var.environment}-subscriptions"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "subscriptions_policy" {
  name   = "${var.environment}-subscriptions"
  policy = "${data.aws_iam_policy_document.subscriptions_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "subscriptions_policy_document" {
  policy_arn = "${aws_iam_policy.subscriptions_policy.arn}"
  role       = "${aws_iam_role.subscriptions_iam_role.name}"
}

#Auth IAM Role
resource "aws_iam_role" "auth_iam_role" {
  name               = "${var.environment}-auth"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "auth_policy" {
  name   = "${var.environment}-auth-policy"
  policy = "${data.aws_iam_policy_document.auth_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "auth_policy_document" {
  policy_arn = "${aws_iam_policy.auth_policy.arn}"
  role       = "${aws_iam_role.auth_iam_role.name}"
}

#butler IAM Role
resource "aws_iam_role" "butler_iam_role" {
  name               = "${var.environment}-butler"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "butler_policy" {
  name   = "${var.environment}-butler-policy"
  policy = "${data.aws_iam_policy_document.butler_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "butler_policy_document" {
  policy_arn = "${aws_iam_policy.butler_policy.arn}"
  role       = "${aws_iam_role.butler_iam_role.name}"
}

#concierge IAM Role
resource "aws_iam_role" "concierge_iam_role" {
  name               = "${var.environment}-concierge"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "concierge_policy" {
  name   = "${var.environment}-concierge-policy"
  policy = "${data.aws_iam_policy_document.concierge_policy_document.json}"
}

resource "aws_iam_policy" "concierge_aws_policy" {
  name   = "${var.environment}-concierge-aws-policy"
  policy = "${data.aws_iam_policy_document.concierge_policy.json}"
}

resource "aws_iam_role_policy_attachment" "concierge_policy_document" {
  policy_arn = "${aws_iam_policy.concierge_policy.arn}"
  role       = "${aws_iam_role.concierge_iam_role.name}"
}

resource "aws_iam_role_policy_attachment" "concierge_aws_policy_document" {
  policy_arn = "${aws_iam_policy.concierge_aws_policy.arn}"
  role       = "${aws_iam_role.concierge_iam_role.name}"
}

#dashboard IAM Role
resource "aws_iam_role" "dashboard_iam_role" {
  name               = "${var.environment}-dashboard"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "dashboard_policy" {
  name   = "${var.environment}-dashboard-policy"
  policy = "${data.aws_iam_policy_document.dashboard_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "dashboard_policy_document" {
  policy_arn = "${aws_iam_policy.dashboard_policy.arn}"
  role       = "${aws_iam_role.dashboard_iam_role.name}"
}

resource "aws_iam_policy" "dashboard_s3_policy" {
  name   = "${var.environment}-dashboard-s3-policy"
  policy = "${data.aws_iam_policy_document.dashboard_s3_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "dashboard_s3_policy_document" {
  policy_arn = "${aws_iam_policy.dashboard_s3_policy.arn}"
  role       = "${aws_iam_role.dashboard_iam_role.name}"
}

#gimli IAM Role
resource "aws_iam_role" "gimli_iam_role" {
  name               = "${var.environment}-gimli"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "gimli_policy" {
  name   = "${var.environment}-gimli-policy"
  policy = "${data.aws_iam_policy_document.gimli_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "gimli_policy_document" {
  policy_arn = "${aws_iam_policy.gimli_policy.arn}"
  role       = "${aws_iam_role.gimli_iam_role.name}"
}

#harvester IAM Role
resource "aws_iam_role" "harvester_iam_role" {
  name               = "${var.environment}-harvester"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "harvester_policy" {
  name   = "${var.environment}-harvester-policy"
  policy = "${data.aws_iam_policy_document.harvester_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "harvester_policy_document" {
  policy_arn = "${aws_iam_policy.harvester_policy.arn}"
  role       = "${aws_iam_role.harvester_iam_role.name}"
}

resource "aws_iam_policy" "harvester_s3_policy" {
  name   = "${var.environment}-harvester-s3-policy"
  policy = "${data.aws_iam_policy_document.harvester_s3_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "harvester_s3_policy_document" {
  policy_arn = "${aws_iam_policy.harvester_s3_policy.arn}"
  role       = "${aws_iam_role.harvester_iam_role.name}"
}

#datahub IAM Role
resource "aws_iam_role" "datahub_iam_role" {
  name               = "${var.environment}-datahub"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "datahub_policy" {
  name   = "${var.environment}-datahub-policy"
  policy = "${data.aws_iam_policy_document.datahub_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "datahub_policy_document" {
  policy_arn = "${aws_iam_policy.datahub_policy.arn}"
  role       = "${aws_iam_role.datahub_iam_role.name}"
}

resource "aws_iam_policy" "datahub_s3_policy" {
  name   = "${var.environment}-datahub-s3-policy"
  policy = "${data.aws_iam_policy_document.datahub_s3_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "datahub_s3_policy_document" {
  policy_arn = "${aws_iam_policy.datahub_s3_policy.arn}"
  role       = "${aws_iam_role.datahub_iam_role.name}"
}

resource "aws_iam_policy" "datahub_sqs_policy" {
  name   = "${var.environment}-datahub-sqs-policy"
  policy = "${data.aws_iam_policy_document.datahub_sqs_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "datahub_sqs_policy_document" {
  policy_arn = "${aws_iam_policy.datahub_sqs_policy.arn}"
  role       = "${aws_iam_role.datahub_iam_role.name}"
}

#hosted IAM Role
resource "aws_iam_role" "hosted_iam_role" {
  name               = "${var.environment}-hosted"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "hosted_policy" {
  name   = "${var.environment}-hosted-policy"
  policy = "${data.aws_iam_policy_document.hosted_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "hosted_policy_document" {
  policy_arn = "${aws_iam_policy.hosted_policy.arn}"
  role       = "${aws_iam_role.hosted_iam_role.name}"
}

#ufh IAM Role
resource "aws_iam_role" "ufh_iam_role" {
  name               = "${var.environment}-ufh"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "ufh_policy" {
  name   = "${var.environment}-ufh-policy"
  policy = "${data.aws_iam_policy_document.ufh_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "ufh_policy_document" {
  policy_arn = "${aws_iam_policy.ufh_policy.arn}"
  role       = "${aws_iam_role.ufh_iam_role.name}"
}

resource "aws_iam_policy" "ufh_s3_policy" {
  name   = "${var.environment}-ufh-s3-policy"
  policy = "${data.aws_iam_policy_document.ufh_s3_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "ufh_s3_policy_document" {
  policy_arn = "${aws_iam_policy.ufh_s3_policy.arn}"
  role       = "${aws_iam_role.ufh_iam_role.name}"
}

resource "aws_iam_policy" "ufh_s3_external_policy" {
  name   = "${var.environment}-ufh-s3-external-policy"
  policy = "${data.aws_iam_policy_document.ufh_s3_external_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "ufh_s3_external_policy_document" {
  policy_arn = "${aws_iam_policy.ufh_s3_external_policy.arn}"
  role       = "${aws_iam_role.ufh_iam_role.name}"
}

resource "aws_iam_policy" "ufh_s3_nps_policy" {
  name   = "${var.environment}-ufh-s3-nps-policy"
  policy = "${data.aws_iam_policy_document.ufh_s3_nps_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "ufh_s3_nps_policy_document" {
  policy_arn = "${aws_iam_policy.ufh_s3_nps_policy.arn}"
  role       = "${aws_iam_role.ufh_iam_role.name}"
}

resource "aws_iam_policy" "ufh_sqs_policy" {
  name   = "${var.environment}-ufh-sqs-policy"
  policy = "${data.aws_iam_policy_document.ufh_sqs_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "ufh_sqs_policy_document" {
  policy_arn = "${aws_iam_policy.ufh_sqs_policy.arn}"
  role       = "${aws_iam_role.ufh_iam_role.name}"
}

resource "aws_iam_policy" "ufh_s3_capital_marketplace_policy" {
  name   = "${var.environment}-ufh-s3-capital-marketplace-policy"
  policy = "${data.aws_iam_policy_document.ufh_s3_capital_marketplace_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "ufh_s3_capital_marketplace_policy_attachment" {
  policy_arn = "${aws_iam_policy.ufh_s3_capital_marketplace_policy.arn}"
  role       = "${aws_iam_role.ufh_iam_role.name}"
}

resource "aws_iam_policy" "ufh_s3_capital_services_policy" {
  name   = "${var.environment}-ufh-s3-capital-services-policy"
  policy = "${data.aws_iam_policy_document.ufh_s3_capital_services_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "ufh_s3_capital_services_policy_attachment" {
  policy_arn = "${aws_iam_policy.ufh_s3_capital_services_policy.arn}"
  role       = "${aws_iam_role.ufh_iam_role.name}"
}

#lumberjack IAM Role
resource "aws_iam_role" "lumberjack_iam_role" {
  name               = "${var.environment}-lumberjack"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "lumberjack_policy" {
  name   = "${var.environment}-lumberjack-policy"
  policy = "${data.aws_iam_policy_document.lumberjack_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "lumberjack_policy_document" {
  policy_arn = "${aws_iam_policy.lumberjack_policy.arn}"
  role       = "${aws_iam_role.lumberjack_iam_role.name}"
}

#datahub-entity-processor IAM Role
resource "aws_iam_role" "datahub-entity-processor_iam_role" {
  name               = "${var.environment}-datahub-entity-processor"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "datahub-entity-processor_policy" {
  name   = "${var.environment}-datahub-entity-processor-policy"
  policy = "${data.aws_iam_policy_document.datahub-entity-processor_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "datahub-entity-processor_policy_document" {
  policy_arn = "${aws_iam_policy.datahub-entity-processor_policy.arn}"
  role       = "${aws_iam_role.datahub-entity-processor_iam_role.name}"
}

resource "aws_iam_policy" "datahub-entity-processor_s3_policy" {
  name   = "${var.environment}-datahub-entity-processor-s3-policy"
  policy = "${data.aws_iam_policy_document.datahub-entity-processor_s3_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "datahub-entity-processor_s3_policy_document" {
  policy_arn = "${aws_iam_policy.datahub-entity-processor_s3_policy.arn}"
  role       = "${aws_iam_role.datahub-entity-processor_iam_role.name}"
}

#datahub-events-stream IAM Role
resource "aws_iam_role" "datahub-events-stream_iam_role" {
  name               = "${var.environment}-datahub-events-stream"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "datahub-events-stream_policy" {
  name   = "${var.environment}-datahub-events-stream-policy"
  policy = "${data.aws_iam_policy_document.datahub-events-stream_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "datahub-events-stream_policy_document" {
  policy_arn = "${aws_iam_policy.datahub-events-stream_policy.arn}"
  role       = "${aws_iam_role.datahub-events-stream_iam_role.name}"
}

resource "aws_iam_policy" "datahub-events-stream_s3_policy" {
  name   = "${var.environment}-datahub-events-stream-s3-policy"
  policy = "${data.aws_iam_policy_document.datahub-events-stream_s3_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "datahub-events-stream_s3_policy_document" {
  policy_arn = "${aws_iam_policy.datahub-events-stream_s3_policy.arn}"
  role       = "${aws_iam_role.datahub-events-stream_iam_role.name}"
}

#shield IAM Role
resource "aws_iam_role" "shield_iam_role" {
  name               = "${var.environment}-shield"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "shield_policy" {
  name   = "${var.environment}-shield-policy"
  policy = "${data.aws_iam_policy_document.shield_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "shield_policy_document" {
  policy_arn = "${aws_iam_policy.shield_policy.arn}"
  role       = "${aws_iam_role.shield_iam_role.name}"
}

# governor IAM Role
resource "aws_iam_role" "governor_iam_role" {
  name               = "${var.environment}-governor"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "governor_policy" {
  name   = "${var.environment}-governor-policy"
  policy = "${data.aws_iam_policy_document.governor_policy_document.json}"
}

resource "aws_iam_policy_attachment" "governor_policy_document" {
  name       = "${var.environment}-governor-attachment"
  policy_arn = "${aws_iam_policy.governor_policy.arn}"
  roles      = ["${aws_iam_role.governor_iam_role.name}"]
}

#scrooge
resource "aws_iam_role" "scrooge_iam_role" {
  name               = "${var.environment}-scrooge"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "scrooge_policy" {
  name   = "${var.environment}-scrooge-policy"
  policy = "${data.aws_iam_policy_document.scrooge_policy_document.json}"
}

resource "aws_iam_policy_attachment" "scrooge_policy_document" {
  name       = "${var.environment}-scrooge-attachment"
  policy_arn = "${aws_iam_policy.scrooge_policy.arn}"
  roles      = ["${aws_iam_role.scrooge_iam_role.name}"]
}

#raven
resource "aws_iam_role" "raven_iam_role" {
  name               = "${var.environment}-raven"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "raven_policy" {
  name   = "${var.environment}-raven-policy"
  policy = "${data.aws_iam_policy_document.raven_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "raven_policy_document" {
  policy_arn = "${aws_iam_policy.raven_policy.arn}"
  role       = "${aws_iam_role.raven_iam_role.name}"
}

resource "aws_iam_policy" "raven_sqs_policy" {
  name   = "${var.environment}-raven-sqs-policy"
  policy = "${data.aws_iam_policy_document.raven_sqs_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "raven_sqs_policy_document" {
  policy_arn = "${aws_iam_policy.raven_sqs_policy.arn}"
  role       = "${aws_iam_role.raven_iam_role.name}"
}

#druid
resource "aws_iam_role" "prod-druid-role" {
  name               = "prod-druid-role"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "druid-policy" {
  name   = "prod-druid-policy"
  policy = "${data.aws_iam_policy_document.prod-druid.json}"
}

resource "aws_iam_policy_attachment" "druid-policy-attachment" {
  name       = "druid-policy-attach"
  policy_arn = "${aws_iam_policy.druid-policy.arn}"
  roles      = ["${aws_iam_role.prod-druid-role.name}"]
}

#neo4j
resource "aws_iam_role" "neo4j_iam_role" {
  name               = "${var.environment}-neo4j"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "neo4j_policy" {
  name   = "${var.environment}-neo4j-policy"
  policy = "${data.aws_iam_policy_document.neo4j_policy_document.json}"
}

resource "aws_iam_policy_attachment" "neo4j_policy_document" {
  name       = "${var.environment}-neo4j-attachment"
  policy_arn = "${aws_iam_policy.neo4j_policy.arn}"
  roles      = ["${aws_iam_role.neo4j_iam_role.name}"]
}

# TiDB IAM Role
resource "aws_iam_role" "tidb_iam_role" {
  name               = "${var.environment}-tidb"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "tidb_policy" {
  name   = "${var.environment}-tidb-policy"
  policy = "${data.aws_iam_policy_document.tidb_policy_document.json}"
}

resource "aws_iam_policy_attachment" "tidb_policy_attachment" {
  name       = "${var.environment}-tidb-policy-attachment"
  policy_arn = "${aws_iam_policy.tidb_policy.arn}"
  roles      = ["${aws_iam_role.tidb_iam_role.name}"]
}

#Pinot iam role
resource "aws_iam_role" "pinot_iam_role" {
  name               = "${var.environment}-apache-pinot"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "pinot_policy" {
  name   = "${var.environment}-apache-pinot-policy"
  policy = "${data.aws_iam_policy_document.pinot_policy_document.json}"
}

resource "aws_iam_policy_attachment" "pinot_policy_attachment" {
  name       = "${var.environment}-apache-pinot-policy-attachment"
  policy_arn = "${aws_iam_policy.pinot_policy.arn}"
  roles      = ["${aws_iam_role.pinot_iam_role.name}"]
}

# PG Availability IAM role
resource "aws_iam_role" "pg_availability_iam_role" {
  name               = "${var.environment}-pg-availability"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "pg_availability_policy" {
  name   = "${var.environment}-pg-availability-policy"
  policy = "${data.aws_iam_policy_document.pg_availability_policy_document.json}"
}

resource "aws_iam_policy_attachment" "pg_availability_policy_document" {
  name       = "${var.environment}-pg-availability-attachment"
  policy_arn = "${aws_iam_policy.pg_availability_policy.arn}"
  roles      = ["${aws_iam_role.pg_availability_iam_role.name}"]
}

# Razorpay-links IAM role

resource "aws_iam_role" "razorpay_links_iam_role" {
  name               = "${var.environment}-razorpay-links"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "razorpay_links_policy" {
  name   = "${var.environment}-razorpay-links-policy"
  policy = "${data.aws_iam_policy_document.razorpay_links_policy_document.json}"
}

resource "aws_iam_policy_attachment" "razorpay_links_policy_document" {
  name       = "${var.environment}-razorpay-links-attachment"
  policy_arn = "${aws_iam_policy.razorpay_links_policy.arn}"
  roles      = ["${aws_iam_role.razorpay_links_iam_role.name}"]
}

#Templating Service IAM Role
resource "aws_iam_role" "templating_service_role" {
  name               = "${var.environment}-templating-service"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "templating_service_s3_write_policy" {
  name   = "${var.environment}-templating-service"
  policy = "${data.aws_iam_policy_document.templating_service_s3_write_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "templating_service_s3_write_policy_attach" {
  name       = "${var.environment}-templating-service"
  policy_arn = "${aws_iam_policy.templating_service_s3_write_policy.arn}"
  roles      = ["${aws_iam_role.templating_service_role.name}"]
}

resource "aws_iam_role" "mysql_slow_logs_iam_role" {
  name               = "${var.environment}-mysql-slow-logs"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "mysql_slow_logs_policy" {
  name   = "${var.environment}-mysql-slow-logs-policy"
  policy = "${data.aws_iam_policy_document.mysql_slow_logs_policy_document.json}"
}

resource "aws_iam_policy_attachment" "mysql_slow_logs_policy_document" {
  name       = "${var.environment}-mysql-slow-logs-attachment"
  policy_arn = "${aws_iam_policy.mysql_slow_logs_policy.arn}"
  roles      = ["${aws_iam_role.mysql_slow_logs_iam_role.name}"]
}

# EBS csi role
resource "aws_iam_role" "aws_csi_ebs_iam_role" {
  name               = "${var.environment}-aws-csi-ebs"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "aws_csi_ebs_policy" {
  name   = "${var.environment}-aws-csi-ebs-policy"
  policy = "${data.aws_iam_policy_document.aws_csi_ebs_policy_document.json}"
}

resource "aws_iam_policy_attachment" "aws_csi_ebs_policy_document" {
  name       = "${var.environment}-aws-csi-ebs-attachment"
  policy_arn = "${aws_iam_policy.aws_csi_ebs_policy.arn}"
  roles      = ["${aws_iam_role.aws_csi_ebs_iam_role.name}"]
}

#Razorflow IAM role
resource "aws_iam_role" "razorflow_role" {
  name               = "${var.environment}-razorflow"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "razorflow_policy" {
  name   = "${var.environment}-razorflow"
  policy = "${data.aws_iam_policy_document.razorflow_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "razorflow_policy_attach" {
  name       = "${var.environment}-razorflow"
  policy_arn = "${aws_iam_policy.razorflow_policy.arn}"
  roles      = ["${aws_iam_role.razorflow_role.name}"]
}

# care iam role
resource "aws_iam_role" "care_iam_role" {
  name               = "${var.environment}-care"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "care_policy" {
  name   = "${var.environment}-care-policy"
  policy = "${data.aws_iam_policy_document.care_policy_document.json}"
}

resource "aws_iam_policy_attachment" "care_policy_attachment" {
  name       = "${var.environment}-care-policy-attachment"
  policy_arn = "${aws_iam_policy.care_policy.arn}"
  roles      = ["${aws_iam_role.care_iam_role.name}"]
}

# ledger iam role
resource "aws_iam_role" "ledger_iam_role" {
  name               = "${var.environment}-ledger"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "ledger_policy" {
  name   = "${var.environment}-ledger-policy"
  policy = "${data.aws_iam_policy_document.ledger_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "ledger_policy_attachment" {
  name       = "${var.environment}-ledger-policy-attachment"
  policy_arn = "${aws_iam_policy.ledger_policy.arn}"
  roles      = ["${aws_iam_role.ledger_iam_role.name}"]
}

# warehouse_web iam role

resource "aws_iam_role" "warehouse_web_iam_role" {
  name               = "${var.environment}-warehouse-web"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "warehouse_web_policy" {
  name   = "${var.environment}-warehouse-web-policy"
  policy = "${data.aws_iam_policy_document.warehouse_web_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "warehouse_web_policy_attachment" {
  name       = "${var.environment}-warehouse-web-policy-attachment"
  policy_arn = "${aws_iam_policy.warehouse_web_policy.arn}"
  roles      = ["${aws_iam_role.warehouse_web_iam_role.name}"]
}

# Sumologic cloudfront logs
resource "aws_iam_role" "sumologic_cloudfront_logs_iam_role" {
  name               = "${var.environment}-sumologic-cloudfront-logs"
  assume_role_policy = "${data.aws_iam_policy_document.sumologic_cloudfront_logs_assume_role.json}"
}

resource "aws_iam_policy" "sumologic_cloudfront_logs_policy" {
  name   = "${var.environment}-sumologic-cloudfront-logs-policy"
  policy = "${data.aws_iam_policy_document.cloudfront_logs_sumologic_doc.json}"
}

resource "aws_iam_policy_attachment" "sumologic_cloudfront_logs_policy_attachment" {
  name       = "${var.environment}-sumologic-cloudfront-logs-policy-attachment"
  policy_arn = "${aws_iam_policy.sumologic_cloudfront_logs_policy.arn}"
  roles      = ["${aws_iam_role.sumologic_cloudfront_logs_iam_role.name}"]
}

# cc-address-service BAD-6281
resource "aws_iam_role" "cc_address_service_iam_role" {
  name               = "${var.environment}-cc-address-service-role"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"

}

resource "aws_iam_policy" "cc_address_service_iam_policy" {
  name   = "${var.environment}-cc-address-service-policy"
  policy = "${data.aws_iam_policy_document.cc_address_service_policy_document.json}"
}

resource "aws_iam_policy_attachment" "cc_address_service_iam_policy_attachment" {
  name       = "${var.environment}-cc-address-service-policy-attachment"
  policy_arn = "${aws_iam_policy.cc_address_service_iam_policy.arn}"
  roles      = ["${aws_iam_role.cc_address_service_iam_role.name}"]
}

resource "aws_iam_role" "shipping_service_iam_role" {
  name               = "${var.environment}-shipping-service"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "shipping_service_policy" {
  name   = "${var.environment}-shipping-service-policy"
  policy = "${data.aws_iam_policy_document.shipping_service_policy_document.json}"
}

resource "aws_iam_policy_attachment" "shipping_service_policy_attachment" {
  name       = "${var.environment}-shipping-service-policy-attachment"
  policy_arn = "${aws_iam_policy.shipping_service_policy.arn}"
  roles      = ["${aws_iam_role.shipping_service_iam_role.name}"]
}

resource "aws_iam_role" "rto_prediction_service_iam_role" {
  name               = "${var.environment}-rto-prediction-service"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "rto_prediction_service_policy" {
  name   = "${var.environment}-rto-prediction-service-policy"
  policy = "${data.aws_iam_policy_document.rto_prediction_service_policy_document.json}"
}

resource "aws_iam_policy_attachment" "rto_prediction_service_policy_attachment" {
  name       = "${var.environment}-rto-prediction-service-policy-attachment"
  policy_arn = "${aws_iam_policy.rto_prediction_service_policy.arn}"
  roles      = ["${aws_iam_role.rto_prediction_service_iam_role.name}"]
}
resource "aws_iam_role" "address_standardization_iam_role" {
  name               = "${var.environment}-address-standardization"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "address_standardization_policy" {
  name   = "${var.environment}-address-standardization-policy"
  policy = "${data.aws_iam_policy_document.address_standardization_policy_document.json}"
}

resource "aws_iam_policy_attachment" "address_standardization_policy_attachment" {
  name       = "${var.environment}-address-standardization-policy-attachment"
  policy_arn = "${aws_iam_policy.address_standardization_policy.arn}"
  roles      = ["${aws_iam_role.address_standardization_iam_role.name}"]
}

# address-service
resource "aws_iam_role" "address_service_iam_role" {
  name               = "${var.environment}-address-service"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "address_service_policy" {
  name   = "${var.environment}-address-service-policy"
  policy = "${data.aws_iam_policy_document.address_service_policy_document.json}"
}

resource "aws_iam_policy_attachment" "address_service_policy_attachment" {
  name       = "${var.environment}-address-service-policy-attachment"
  policy_arn = "${aws_iam_policy.address_service_policy.arn}"
  roles      = ["${aws_iam_role.address_service_iam_role.name}"]
}


# Growth-Service IAM role
resource "aws_iam_role" "growth_service_iam_role" {
  name               = "${var.environment}-growth-service"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "growth_service_policy" {
  name   = "${var.environment}-growth-service-policy"
  policy = "${data.aws_iam_policy_document.growth_service_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "growth_service_policy_attachment" {
  name       = "${var.environment}-growth-service-policy-attachment"
  policy_arn = "${aws_iam_policy.growth_service_policy.arn}"
  roles      = ["${aws_iam_role.growth_service_iam_role.name}"]
}

resource "aws_iam_policy" "checkout-static-prod-invalidate-cloudfront-cache-policy" {
  name   = "${var.environment}-checkout-static-prod-invalidate-cloudfront-cache-policy"
  policy = "${data.aws_iam_policy_document.checkout-static-prod-invalidate-cloudfront-cache.json}"
}

resource "aws_iam_policy_attachment" "checkout-static-prod-invalidate-cloudfront-cache-policy-attachment" {
  name       = "${var.environment}-checkout-static-prod-invalidate-cloudfront-cache-policy-attachment"
  policy_arn = "${aws_iam_policy.checkout-static-prod-invalidate-cloudfront-cache-policy.arn}"
  roles      = ["${data.aws_iam_role.gha-prod-frontend_checkout.name}"]
}

# custom domain service
resource "aws_iam_role" "prod-custom-domain-iam-role" {
  name               = "prod-custom-domain"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod-custom-domain-policy" {
  name   = "prod-custom-domain-policy"
  policy = "${data.aws_iam_policy_document.prod-custom-domain-policy-documents.json}"
}

resource "aws_iam_policy_attachment" "prod-custom-domain-policy-attachment" {
  name       = "prod-custom-domain-policy-attachment"
  policy_arn = "${aws_iam_policy.prod-custom-domain-policy.arn}"
  roles      = ["${aws_iam_role.prod-custom-domain-iam-role.name}"]
}

resource "aws_iam_role" "custom_solutions_web_iam_role" {
  name               = "${var.environment}-custom-solutions-web"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "custom_solutions_web_policy" {
  name   = "${var.environment}-custom-solutions-web-policy"
  policy = "${data.aws_iam_policy_document.custom_solutions_web_policy_document.json}"
}

resource "aws_iam_policy_attachment" "custom_solutions_web_policy_attachment" {
  name       = "${var.environment}-custom-solutions-web-policy-attachment"
  policy_arn = "${aws_iam_policy.custom_solutions_web_policy.arn}"
  roles      = ["${aws_iam_role.custom_solutions_web_iam_role.name}"]
}

resource "aws_iam_role" "prod-chotabeam-iam-role" {
  name               = "prod-chotabeam"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod-chotabeam-policy" {
  name   = "prod-chotabeam-policy"
  policy = "${data.aws_iam_policy_document.prod-chotabeam-policy-document.json}"
}

resource "aws_iam_policy_attachment" "prod-chotabeam-policy-attachment" {
  name       = "prod-chotabeam-policy-attachment"
  policy_arn = "${aws_iam_policy.prod-chotabeam-policy.arn}"
  roles      = ["${aws_iam_role.prod-chotabeam-iam-role.name}"]
}

resource "aws_iam_role" "subscriptions_dark_iam_role" {
  name               = "dark-subscriptions"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "subscriptions_dark_policy" {
  name   = "dark-subscriptions"
  policy = "${data.aws_iam_policy_document.subscriptions_dark_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "subscriptions_dark_policy_document" {
  policy_arn = "${aws_iam_policy.subscriptions_dark_policy.arn}"
  role       = "${aws_iam_role.subscriptions_dark_iam_role.name}"
}

# Capital LOS
resource "aws_iam_role" "prod_capital_los_iam_role" {
  name               = "prod-capital-los"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod_capital_los_sqs_policy" {
  name   = "prod-capital-los-sqs-policy"
  policy = "${data.aws_iam_policy_document.prod_capital_los_sqs_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "prod_capital_los_sqs_policy_attachment" {
  name       = "prod-capital-los-sqs-policy-attachment"
  policy_arn = "${aws_iam_policy.prod_capital_los_sqs_policy.arn}"
  roles      = ["${aws_iam_role.prod_capital_los_iam_role.name}"]
}

# Capital Scorecard

resource "aws_iam_role" "prod_capital_scorecard_iam_role" {
  name               = "prod-capital-scorecard"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod_capital_scorecard_sqs_policy" {
  name   = "prod-capital-scorecard-sqs-policy"
  policy = "${data.aws_iam_policy_document.prod_capital_scorecard_sqs_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "prod_capital_scorecard_sqs_policy_attachment" {
  name       = "prod-capital-scorecard-sqs-policy-attachment"
  policy_arn = "${aws_iam_policy.prod_capital_scorecard_sqs_policy.arn}"
  roles      = ["${aws_iam_role.prod_capital_scorecard_iam_role.name}"]
}

# Partnerships
resource "aws_iam_role" "partnerships_iam_role" {
  name               = "${var.environment}-partnerships"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "partnerships_policy" {
  name   = "${var.environment}-partnerships-policy"
  policy = "${data.aws_iam_policy_document.partnerships_policy_document.json}"
}

resource "aws_iam_policy_attachment" "partnerships_policy_attachment" {
  name       = "${var.environment}-partnerships-policy-attachment"
  policy_arn = "${aws_iam_policy.partnerships_policy.arn}"
  roles      = ["${aws_iam_role.partnerships_iam_role.name}"]
}

# consumer-app
resource "aws_iam_role" "consumer_app_iam_role" {
  name               = "${var.environment}-consumer-app"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "consumer_app_policy" {
  name   = "${var.environment}-consumer-app-policy"
  policy = "${data.aws_iam_policy_document.consumer_app_policy_document.json}"
}

resource "aws_iam_policy_attachment" "consumer_app_policy_attachment" {
  name       = "${var.environment}-consumer-app-policy-attachment"
  policy_arn = "${aws_iam_policy.consumer_app_policy.arn}"
  roles      = ["${aws_iam_role.consumer_app_iam_role.name}"]
}

# no-code-apps service
resource "aws_iam_role" "prod-no-code-apps-iam-role" {
  name               = "prod-no-code-apps"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod-no-code-apps-policy" {
  name   = "prod-no-code-apps-policy"
  policy = "${data.aws_iam_policy_document.prod-no-code-apps-policy-documents.json}"
}

resource "aws_iam_policy_attachment" "prod-no-code-apps-policy-attachment" {
  name       = "prod-no-code-apps-policy-attachment"
  policy_arn = "${aws_iam_policy.prod-no-code-apps-policy.arn}"
  roles      = ["${aws_iam_role.prod-no-code-apps-iam-role.name}"]
}

# Capital Lender
resource "aws_iam_role" "prod_capital_lender_iam_role" {
  name               = "prod-capital-lender"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod_capital_lender_sqs_policy" {
  name   = "prod-capital-lender-sqs-policy"
  policy = "${data.aws_iam_policy_document.prod_capital_lender_sqs_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "prod_capital_lender_sqs_policy_attachment" {
  name       = "prod-capital-lender-sqs-policy-attachment"
  policy_arn = "${aws_iam_policy.prod_capital_lender_sqs_policy.arn}"
  roles      = ["${aws_iam_role.prod_capital_lender_iam_role.name}"]
}

# Capital LOC
resource "aws_iam_role" "prod_capital_loc_iam_role" {
  name               = "prod-capital-loc"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod_capital_loc_sqs_policy" {
  name   = "prod-capital-loc-sqs-policy"
  policy = "${data.aws_iam_policy_document.prod_capital_loc_sqs_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "prod_capital_loc_sqs_policy_attachment" {
  name       = "prod-capital-loc-sqs-policy-attachment"
  policy_arn = "${aws_iam_policy.prod_capital_loc_sqs_policy.arn}"
  roles      = ["${aws_iam_role.prod_capital_loc_iam_role.name}"]
}

# Capital ES
resource "aws_iam_role" "prod_capital_es_iam_role" {
  name               = "prod-capital-es"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "prod_capital_es_sqs_policy" {
  name   = "prod-capital-es-sqs-policy"
  policy = "${data.aws_iam_policy_document.prod_capital_es_sqs_policy_documents.json}"
}

resource "aws_iam_policy_attachment" "prod_capital_es_sqs_policy_attachment" {
  name       = "prod-capital-es-sqs-policy-attachment"
  policy_arn = "${aws_iam_policy.prod_capital_es_sqs_policy.arn}"
  roles      = ["${aws_iam_role.prod_capital_es_iam_role.name}"]
}
