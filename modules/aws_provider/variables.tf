variable "branch" {
  default = "master"
}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "ap-southeast-2"
}

variable "aws_account" {
  description = "AWS account number to assume role"
}

variable "aws_role_name" {
  description = "AWS role name to assume"
}

variable "aws_external_id" {
  description = "AWS external id to assume role"
}
