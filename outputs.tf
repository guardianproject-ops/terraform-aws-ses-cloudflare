output "ses_identity_arn" {
  description = "SES identity ARN."
  value       = aws_ses_domain_identity.main.arn
}

output "smtp_server" {
  description = "The SMTP server hostname to use when sending mail"
  value       = "email-smtp.${data.aws_region.current.name}.amazonaws.com"
}
