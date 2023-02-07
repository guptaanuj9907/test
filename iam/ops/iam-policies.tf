resource "aws_iam_policy" "cloudwatch-exporter-policy" {
  name        = "cloudwatch-exporter-policy"
  description = "allows cloudwatch exporter to scrape cloudwatch"
  policy      = "${data.aws_iam_policy_document.cloudwatch-exporter-policy.json}"
}

resource "aws_iam_policy" "github-actions-prod-mandate-manager-fe-policy" {
  name   = "github-actions-prod-mandate-manager-fe-policy"
  policy = "${data.aws_iam_policy_document.github-actions-prod-mandate-manager-fe-policy.json}"
}
