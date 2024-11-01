output "primary_bucket_name" {
  value = aws_s3_bucket.primary_bucket.id
}

output "secondary_bucket_name" {
  value = aws_s3_bucket.secondary_bucket.id
}

output "primary_bucket_arn" {
  value = aws_s3_bucket.primary_bucket.arn
}

output "secondary_bucket_arn" {
  value = aws_s3_bucket.secondary_bucket.arn
}