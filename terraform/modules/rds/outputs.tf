output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.rds_vpc.id
}

output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = aws_subnet.public[*].id
}

output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = aws_db_instance.prevail_db.endpoint
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.prevail_db.port
}

output "security_group_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.rds_sg.id
}

output "db_subnet_group_name" {
  description = "Name of the DB subnet group"
  value       = aws_db_subnet_group.rds_subnet_group.name
}

output "rds_instance_id" {
  description = "Identifier of the RDS instance"
  value       = aws_db_instance.prevail_db.id
}

output "monitoring_role_arn" {
  description = "ARN of the RDS monitoring role"
  value       = aws_iam_role.rds_monitoring_role.arn
}
output "primary_endpoint" {
  description = "Endpoint of the primary RDS instance"
  value       = aws_db_instance.prevail_db.endpoint
}

# output "replica_endpoint" {
#   description = "Endpoint of the read replica"
#   value       = aws_db_instance.replica.endpoint
# }

output "primary_arn" {
  description = "ARN of the primary RDS instance"
  value       = aws_db_instance.prevail_db.arn
}

# output "replica_arn" {
#   description = "ARN of the read replica"
#   value       = aws_db_instance.replica.arn
# }