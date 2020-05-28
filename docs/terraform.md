## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |
| cloudflare | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| attributes | Additional attributes (e.g., `one', or `two') | `list` | `[]` | no |
| cloudflare\_zone\_id | The zone id of the zone | `string` | n/a | yes |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name`, and `attributes` | `string` | `"-"` | no |
| dmarc\_p | DMARC Policy for organizational domains (none, quarantine, reject). | `string` | `"none"` | no |
| dmarc\_rua | DMARC Reporting URI of aggregate reports, expects an email address. | `string` | n/a | yes |
| domain\_name | The domain name to configure SES. | `string` | n/a | yes |
| environment | Environment (e.g. `test`, `dev`) | `string` | `""` | no |
| mail\_from\_domain | Subdomain (of the route53 zone) which is to be used as MAIL FROM address | `string` | n/a | yes |
| name | Name  (e.g. `app` or `database`) | `string` | n/a | yes |
| namespace | Namespace (e.g. `org`) | `string` | n/a | yes |
| stage | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `""` | no |
| tags | Additional tags (e.g. map(`Visibility`,`Public`) | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| ses\_identity\_arn | SES identity ARN. |
| smtp\_server | The SMTP server hostname to use when sending mail |

