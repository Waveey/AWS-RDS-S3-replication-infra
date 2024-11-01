variable "firm_id_key" {
  description = "Prevail firm identifier key"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "replication_role_arn" {
  description = "ARN of the IAM role for replication"
  type        = string
}

variable "destination_account_id" {
  description = "AWS account ID of the destination account"
  type        = string
}
