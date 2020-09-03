terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.4.0"
    }
    cloudflare = {
      source  = "terraform-providers/cloudflare"
      version = "~> 2.0"
    }
  }
}
