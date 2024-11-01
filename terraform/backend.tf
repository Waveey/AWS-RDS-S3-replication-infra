terraform {
  backend "s3" {
    bucket         = "prevailbucket21321"
    key            = "replication/terraform.tfstate"
    region         = "us-east-1"
    # profile        = "kube"
    encrypt        = "true"
    # dynamodb_table = "dev-terraform-state-lock-table"
  }
}