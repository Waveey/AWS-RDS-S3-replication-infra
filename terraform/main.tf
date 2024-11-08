
module "s3" {
  source = "./modules/s3"

  firm_id_key            = var.firm_id_key
  environment            = var.environment
  replication_role_arn   = module.iam.replication_role_arn
  destination_account_id = var.destination_account_id
  providers = {
    aws.primary   = aws.primary
    aws.secondary = aws.secondary
  }
}


module "iam" {
  source = "./modules/iam"
  
  firm_id_key         = var.firm_id_key
  secondary_account_id = var.destination_account_id
  tags                = var.tags
  environment = var.environment
  primary_bucket_arn   = module.s3.primary_bucket_arn

  providers = {
    aws.primary = aws.primary
  }
}

module "rds" {
  source = "./modules/rds"
  firm_id_key           = var.firm_id_key
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  availability_zones    = var.availability_zones
  db_password          = var.db_password
  instance_type =  var.instance_type
  destination_account_id = var.destination_account_id
  db_name = var.db_name
  db_username = var.db_username
  providers = {
    aws.primary   = aws.primary
    aws.secondary = aws.secondary
  }
}







