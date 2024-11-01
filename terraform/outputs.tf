
output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds.rds_endpoint
}

output "rds_port" {
  description = "RDS instance port"
  value       = module.rds.rds_port
}

output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.rds.vpc_id
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = module.rds.subnet_ids
}

output "source_bucket_name" {
  description = "Name of the source S3 bucket"
  value       = module.s3.primary_bucket_name
}

output "destination_bucket_name" {
  description = "Name of the destination S3 bucket"
  value       = module.s3.secondary_bucket_name
}