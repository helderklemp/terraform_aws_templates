variable "branch" {
  default = "master"
}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "ap-southeast-2"
}

variable "external_id" {
  description = "external_id"
}

variable "role_arn" {
  description = "role_arn"
}

variable "session_name" {
  description = "terraform_clien session namet"
}
