variable "branch" {
  default = "master"
}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "ap-southeast-2"
}

variable "vpc_name" {}
