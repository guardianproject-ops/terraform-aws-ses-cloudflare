variable "dmarc_p" {
  description = "DMARC Policy for organizational domains (none, quarantine, reject)."
  type        = string
  default     = "none"
}

variable "dmarc_rua" {
  description = "DMARC Reporting URI of aggregate reports, expects an email address."
  type        = string
}

variable "domain_name" {
  description = "The domain name to configure SES."
  type        = string
}

variable "mail_from_domain" {
  description = " Subdomain (of the route53 zone) which is to be used as MAIL FROM address"
  type        = string
}

variable "cloudflare_zone_id" {
  type        = string
  description = "The zone id of the zone"
}