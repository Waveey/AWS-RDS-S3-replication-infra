output "replication_role_arn" {
  description = "ARN of the S3 replication IAM role"
  value       = aws_iam_role.s3_replication.arn
}

output "replication_role_name" {
  description = "Name of the S3 replication IAM role"
  value       = aws_iam_role.s3_replication.name
}

output "access_key_id" {
  value = aws_iam_access_key.s3_user_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.s3_user_key.secret
  sensitive = true
}
output "primary_bucket_arn" {
  value = aws_s3_bucket.primary_bucket.arn
  description = "The ARN of the primary S3 bucket"
}