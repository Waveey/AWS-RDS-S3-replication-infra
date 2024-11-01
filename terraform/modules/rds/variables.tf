variable "firm_id_key" {
  description = "Prevail firm identifier key"
  type        = string
}

variable "db_password" {
  description = "Master password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones for subnet creation"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "environment" {
  description = "Environment name for resource tagging"
  type        = string
  default     = "production"
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}

variable "db_name" {
  description = "DB name"
  type        = string
}

variable "db_username" {
  description = "DB username"
  type        = string
}


variable "instance_type" {
  description = "DB instance type"
  type        = string
  default = "db.t3.medium"
}

variable "destination_account_id" {
  description = "AWS account ID of the destination account"
  type        = string
}

