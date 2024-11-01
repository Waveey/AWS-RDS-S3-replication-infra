variable "firm_id_key" {
  description = "Prevail firm identifier key"
  type        = string
}

variable "tags" {
  description = "Tags to apply to IAM resources"
  type        = map(string)
  default     = {}
}

variable "secondary_account_id" {
  description = "AWS account ID of the secondary (destination) account"
  type        = string
}
