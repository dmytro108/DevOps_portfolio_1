resource "aws_iam_user" "oversecured_user" {
  name          = var.user_name
  path          = var.user_path
  force_destroy = true

  tags = {
    "Name" = "${var.name_pref}user"
  }
}

resource "aws_iam_user_login_profile" "oversecured" {
  user = aws_iam_user.oversecured_user.name

}

resource "aws_iam_policy" "check_right" {
  description = "A test policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "NotAction" : [
          "iam:*",
          "organizations:*",
          "account:*"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:CreateServiceLinkedRole",
          "iam:DeleteServiceLinkedRole",
          "iam:ListRoles",
          "organizations:DescribeOrganization",
          "account:ListRegions"
        ],
        "Resource" : "*"
      }
    ]
  })

  tags = {
    "Name" = "${var.name_pref}policy"
  }

}

resource "aws_iam_user_policy_attachment" "check_right_user" {
  user       = aws_iam_user.oversecured_user.name
  policy_arn = aws_iam_policy.check_right.arn
}