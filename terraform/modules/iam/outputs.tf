output "replication_role_arn" {
  description = "ARN of the S3 replication IAM role"
  value       = aws_iam_role.s3_replication.arn
}

output "replication_role_name" {
  description = "Name of the S3 replication IAM role"
  value       = aws_iam_role.s3_replication.name
}

output "s3_user_access_key" {
  value = aws_iam_access_key.s3_user_key.id
  sensitive = true
}

output "s3_user_secret_key" {
  value = aws_iam_access_key.s3_user_key.secret
  sensitive = true
}