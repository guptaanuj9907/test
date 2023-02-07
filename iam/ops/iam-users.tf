# cloudwatch exporter with role annotation not producing any metrics, hence user based policy
resource "aws_iam_user" "cloudwatch-exporter-user" {
  name = "cloudwatch-exporter-user"
}

resource "aws_iam_user_policy_attachment" "cloudwatch-exporter-user-attachment" {
  user       = "${aws_iam_user.cloudwatch-exporter-user.name}"
  policy_arn = "${aws_iam_policy.cloudwatch-exporter-policy.arn}"
}

resource "aws_iam_user" "github-actions-prod-mandate-manager-fe" {
  name = "github-actions-prod-mandate-manager-fe"
}

resource "aws_iam_user_policy_attachment" "github-actions-prod-mandate-manager-fe-policy-attachment" {
  user       = "${aws_iam_user.github-actions-prod-mandate-manager-fe.name}"
  policy_arn = "${aws_iam_policy.github-actions-prod-mandate-manager-fe-policy.arn}"
}
