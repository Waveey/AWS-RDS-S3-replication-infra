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


# IAM user for s3
resource "aws_iam_user" "s3_user" {
  name = "s3-bucket-user-${var.firm_id_key}"
  
  tags = merge(
    var.tags,
    {
      Name = "S3BucketUser-${var.firm_id_key}"
    }
  )
}

# Access key for the IAM user
resource "aws_iam_access_key" "s3_user_key" {
  user = aws_iam_user.s3_user.name
}

resource "aws_iam_user_policy" "s3_user_policy" {
  name = "s3-bucket-access-${var.firm_id_key}"
  user = aws_iam_user.s3_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*"  # Allows all S3 actions
        ]
        Resource = [
          var.primary_bucket_arn,
          "${var.primary_bucket_arn}/*"  # Access to bucket and all objects within it
        ]
      }
    ]
  })
}