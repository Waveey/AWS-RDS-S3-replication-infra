terraform {
  backend "s3" {
    bucket         = "cogbuck123"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    profile        = "kube"
    encrypt        = "true"
    # dynamodb_table = "dev-terraform-state-lock-table"
  }
}