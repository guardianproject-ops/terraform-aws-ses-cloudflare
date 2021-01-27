output "ses_identity_arn" {
  description = "SES identity ARN."
  value       = aws_ses_domain_identity.main.arn
}

output "smtp_server" {
  description = "The SMTP server hostname to use when sending mail"
  value       = "email-smtp.${data.aws_region.current.name}.amazonaws.com"
}

output "smtp_username" {
  description = "The username used for SMTP authentication"
  value       = join("", aws_iam_access_key.smtp.*.id)
}

output "smtp_password" {
  description = "The password used for SMTP authentication"
  value       = join("", aws_iam_access_key.smtp.*.ses_smtp_password_v4)
}

output "smtp_port" {
  description = "The port used for SMTP connection"
  value       = 587
}

output "iam_user_arn" {
  value       = join("", aws_iam_user.smtp.*.arn)
  description = "The ARN assigned by AWS for this user."
}

output "iam_user_unique_id" {
  value       = join("", aws_iam_user.smtp.*.unique_id)
  description = "The unique ID assigned by AWS."
}

output "iam_access_key_id" {
  value       = join("", aws_iam_access_key.smtp.*.id)
  description = "The access key ID for the smtp iam user"
}

output "iam_secret_access_key" {
  value       = join("", aws_iam_access_key.smtp.*.secret)
  description = "The secret access key for the smtp iam user. This will be written to the state file in plain-text."
}
