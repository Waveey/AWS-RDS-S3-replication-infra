resource "aws_iam_role" "s3_replication" {
  name = "S3ReplicationRole-${var.firm_id_key}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    var.tags,
    {
      Name = "S3ReplicationRole-${var.firm_id_key}"
    }
  )
}

resource "aws_iam_role_policy" "s3_replication" {
  name = "s3-replication-policy-${var.firm_id_key}"
  role = aws_iam_role.s3_replication.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetReplicationConfiguration",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::prevail-${var.firm_id_key}"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging",
          "s3:GetObjectRetention",
          "s3:GetObjectLegalHold"
        ]
        Resource = [
          "arn:aws:s3:::prevail-${var.firm_id_key}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags",
          "s3:ObjectOwnerOverrideToBucketOwner"
        ]
        Resource = [
          "arn:aws:s3:::prevail-${var.firm_id_key}-replica/*"
        ]
      }
    ]
  })
}

# Create IAM user
resource "aws_iam_user" "s3_user" {
  provider = aws.primary
  name     = "s3-user-${var.firm_id_key}"
  
  tags = {
    Environment = var.environment
  }
}

# Create access key for the IAM user
resource "aws_iam_access_key" "s3_user_key" {
  provider = aws.primary
  user     = aws_iam_user.s3_user.name
}

# Create IAM policy for S3 bucket access
resource "aws_iam_policy" "s3_access_policy" {
  provider    = aws.primary
  name        = "s3-access-policy-${var.firm_id_key}"
  description = "Policy for full access to specific S3 bucket"

   policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowBucketOnly"
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = [
          var.bucket_arn,
          "${var.bucket_arn}/*"
        ]
      }
    ]
  })
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "s3_policy_attach" {
  provider   = aws.primary
  user       = aws_iam_user.s3_user.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

