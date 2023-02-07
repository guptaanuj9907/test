# harbor
resource "aws_iam_role" "harbor_iam_role" {
  name               = "${var.environment}-harbor"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "harbor_policy" {
  name   = "${var.environment}-harbor-policy"
  policy = "${data.aws_iam_policy_document.harbor_policy_document.json}"
}

resource "aws_iam_policy_attachment" "harbor_policy_document" {
  name       = "${var.environment}-harbor-attachment"
  policy_arn = "${aws_iam_policy.harbor_policy.arn}"
  roles      = ["${aws_iam_role.harbor_iam_role.name}"]
}

# Terraform Registry (Citizen)

resource "aws_iam_role" "tfregistry_iam_role" {
  name               = "${var.environment}-tfregistry"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "tfregistry_policy" {
  name        = "tfregistry-policy"
  description = "allows tfregistry to store module files"
  policy      = "${data.aws_iam_policy_document.tfregistry_policy_document.json}"
}

resource "aws_iam_policy_attachment" "tfregistry_policy_document" {
  name       = "${var.environment}-tfregistry-attachment"
  policy_arn = "${aws_iam_policy.tfregistry_policy.arn}"
  roles      = ["${aws_iam_role.tfregistry_iam_role.name}"]
}

# RDSLogs
resource "aws_iam_role" "rdslogs_iam_role" {
  name               = "${var.environment}-rdslogs"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "rdslogs_policy" {
  name   = "${var.environment}-rdslogs-policy"
  policy = "${data.aws_iam_policy_document.rdslogs_policy_document.json}"
}

resource "aws_iam_policy_attachment" "rdslogs_policy_document" {
  name       = "${var.environment}-rdslogs-attachment"
  policy_arn = "${aws_iam_policy.rdslogs_policy.arn}"
  roles      = ["${aws_iam_role.rdslogs_iam_role.name}"]
}

# rds-sumologic iam role
resource "aws_iam_role" "rds_sumologic_iam_role" {
  name               = "${var.environment}-rds-sumologic-lambda"
  assume_role_policy = "${data.aws_iam_policy_document.lambda-assume-role.json}"
}

resource "aws_iam_policy" "rds_sumologic_policy" {
  name   = "${var.environment}-rds-sumologic-lambda-policy"
  policy = "${data.aws_iam_policy_document.rds_sumologic_policy_document.json}"
}

resource "aws_iam_policy_attachment" "rds_sumologic_policy_attachment" {
  name       = "${var.environment}-rds-sumologic-lambda-policy-attachment"
  policy_arn = "${aws_iam_policy.rds_sumologic_policy.arn}"
  roles      = ["${aws_iam_role.rds_sumologic_iam_role.name}"]
}

#WAF Automation
resource "aws_iam_role" "ops_waf_automation_role" {
  name               = "${var.environment}-waf-automation"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "waf_automation_policy" {
  name   = "${var.environment}-waf-automation-policy"
  policy = "${data.aws_iam_policy_document.waf_policy_document.json}"
}

resource "aws_iam_policy_attachment" "waf_automation_policy_attachment" {
  name       = "${var.environment}-waf-automation-policy-attachment"
  policy_arn = "${aws_iam_policy.waf_automation_policy.arn}"
  roles      = ["${aws_iam_role.ops_waf_automation_role.name}"]
}

# Cost data refresher
# Reports uploaded by aws by default objects are owned by AWS account
# Copying this data over to same location creates objects owned by production account.
# Runs as cronjob to sync data.
resource "aws_iam_role" "cur_refresher_iam_role" {
  name               = "${var.environment}-cur-refresher"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
}

resource "aws_iam_policy" "cur_refresher_policy" {
  name   = "${var.environment}-cur-refresher-policy"
  policy = "${data.aws_iam_policy_document.cur_refresher_policy_document.json}"
}

resource "aws_iam_policy_attachment" "cur_refresher_policy_document" {
  name       = "${var.environment}-cur-refresher-attachment"
  policy_arn = "${aws_iam_policy.cur_refresher_policy.arn}"
  roles      = ["${aws_iam_role.cur_refresher_iam_role.name}"]
}

# cartography tool IAM Role
resource "aws_iam_role" "security_cartography" {
  name               = "${var.env}-security-cartography"
  assume_role_policy = "${data.aws_iam_policy_document.services-assume-role.json}"
  max_session_duration = 10800
}

resource "aws_iam_policy" "security_cartography_service_policy" {
  name   = "${var.env}-security-cartography"
  policy = "${data.aws_iam_policy_document.security_cartography_service.json}"
}

resource "aws_iam_policy_attachment" "security_cartography_service_policy_attachment" {
  name       = "${var.env}-security-cartography"
  policy_arn = "${aws_iam_policy.security_cartography_service_policy.arn}"
  roles      = ["${aws_iam_role.security_cartography.name}"]
}

resource "aws_iam_policy_attachment" "security_cartography_security_audit_attachment" {
  name       = "${var.env}-security-cartography"
  policy_arn = "${data.aws_iam_policy.security_audit.arn}"
  roles      = ["${aws_iam_role.security_cartography.name}"]
}

