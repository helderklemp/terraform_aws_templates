variable "branch" {
  default = "master"
}

variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "ap-southeast-2"
}

variable availability_zones {
  description = "Availability zones"
  default     = ["ap-southeast-2-1a", "ap-southeast-2-1b", "ap-southeast-2-1c"]
}

variable "amis" {
  description = "AMIs by region"

  default = "ami-f1810f86"
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the Public Subnet"
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for the Private Subnet"
  default     = "10.0.1.0/24"
}
