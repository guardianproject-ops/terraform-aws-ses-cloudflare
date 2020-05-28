locals {
  # strip trailing . in domain names
  stripped_domain_name      = replace(var.domain_name, "/[.]$/", "")
  stripped_mail_from_domain = replace(var.mail_from_domain, "/[.]$/", "")
  dash_domain               = replace(var.domain_name, ".", "-")
}

resource "aws_ses_domain_identity" "main" {
  domain = var.domain_name
}

resource "cloudflare_record" "ses_verification" {
  zone_id = var.cloudflare_zone_id
  name    = "_amazonses.${var.domain_name}"
  value   = aws_ses_domain_identity.main.verification_token
  type    = "TXT"
  ttl     = 600
}

resource "aws_ses_domain_identity_verification" "verification" {
  domain = aws_ses_domain_identity.main.id

  depends_on = [
    cloudflare_record.ses_verification
  ]
}

resource "aws_ses_domain_dkim" "main" {
  domain = aws_ses_domain_identity.main.domain
}


resource "cloudflare_record" "ses_dkim" {
  count   = 3
  zone_id = var.cloudflare_zone_id
  type    = "CNAME"
  ttl     = 600
  name = format(
    "%s._domainkey.%s",
    element(aws_ses_domain_dkim.main.dkim_tokens, count.index),
    var.domain_name,
  )
  value = "${element(aws_ses_domain_dkim.main.dkim_tokens, count.index)}.dkim.amazonses.com"
}

resource "aws_ses_domain_mail_from" "main" {
  domain           = aws_ses_domain_identity.main.domain
  mail_from_domain = local.stripped_mail_from_domain
}

resource "cloudflare_record" "spf_mail_from" {
  zone_id = var.cloudflare_zone_id
  name    = aws_ses_domain_mail_from.main.mail_from_domain
  value   = "v=spf1 include:amazonses.com -all"
  type    = "TXT"
  ttl     = 600
}

resource "cloudflare_record" "spf_domain" {
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name
  value   = "v=spf1 include:amazonses.com -all"
  type    = "TXT"
  ttl     = 600
}

data "aws_region" "current" {
}

resource "cloudflare_record" "mx_send_mail_from" {
  zone_id  = var.cloudflare_zone_id
  name     = aws_ses_domain_mail_from.main.mail_from_domain
  value    = "feedback-smtp.${data.aws_region.current.name}.amazonses.com"
  priority = 10
  type     = "MX"
  ttl      = 600
}

resource "cloudflare_record" "txt_dmarc" {
  zone_id = var.cloudflare_zone_id
  name    = "_dmarc.${var.domain_name}"
  value   = "v=DMARC1; p=${var.dmarc_p}; rua=mailto:${var.dmarc_rua};"
  type    = "TXT"
  ttl     = 600
}
