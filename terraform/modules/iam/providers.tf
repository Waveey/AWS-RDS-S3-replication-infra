terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      configuration_aliases = [aws.primary]
      version = "~> 5.0"
    }
  }
}