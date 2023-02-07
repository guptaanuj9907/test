#User for hvault-mhq
resource "aws_iam_user" "hvault-mhq" {
  name = "kube-api-prod-hvault-mhq"
}

resource "aws_iam_user_policy_attachment" "hvault-mhq-attachment" {
  user       = "${aws_iam_user.hvault-mhq.name}"
  policy_arn = "${aws_iam_policy.hvault_mhq_policy.arn}"
}

#mandatehq
resource "aws_iam_user" "mandatehq" {
  name = "mandatehq"
}
