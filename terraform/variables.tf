variable "firm_id_key" {
  description = "Prevail firm identifier key"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "destination_bucket_arn" {
  description = "ARN of the destination bucket for replication"
  type        = string
}

variable "destination_account_id" {
  description = "AWS account ID of the destination account"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "db_password" {
  description = "Password for RDS instance"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "DB name"
  type        = string
}

variable "db_username" {
  description = "DB username"
  type        = string
}

variable "tags" {
  description = "Common tags for resources"
  type        = map(string)
  default     = {}
}

variable "secondary_account_role_arn" {
  description = "arn:aws:iam::680561426780:role/cross-account-role"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "DB instance type"
  type        = string
  default = "db.t3.medium"
}

variable "access_key" {
  description = "DB instance type"
  type        = string
  
}

variable "secret_key" {
  description = "DB instance type"
  type        = string

}





