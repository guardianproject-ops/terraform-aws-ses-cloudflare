resource "aws_iam_user" "smtp" {
  count = var.smtp_user_enabled ? 1 : 0
  name  = module.this.id
  tags  = module.this.tags
}

resource "aws_iam_access_key" "smtp" {
  count = var.smtp_user_enabled ? 1 : 0
  user  = aws_iam_user.smtp[0].name
}

data "aws_iam_policy_document" "ses_user_policy" {
  statement {
    actions = var.iam_permissions
    resources = [
      aws_ses_domain_identity.main.arn,
      "arn:aws:ses:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:identity/*"
    ]
  }
}

resource "aws_iam_user_policy" "sending_emails" {
  count = var.smtp_user_enabled ? 1 : 0

  name   = module.this.id
  policy = data.aws_iam_policy_document.ses_user_policy.json
  user   = aws_iam_user.smtp[0].name
}
