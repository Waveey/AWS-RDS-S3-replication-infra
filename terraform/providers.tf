
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Primary provider
provider "aws" {
  region = "us-east-1"
  alias  = "primary"
  profile = "kube"
}

# Secondary provider ( replication)
provider "aws" {
  region = "us-east-1"
  alias  = "secondary"
  access_key = var.access_key
  secret_key = var.secret_key
  # assume_role {
  #   role_arn = var.secondary_account_role_arn
}