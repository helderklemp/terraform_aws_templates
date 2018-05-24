provider "aws" {
  region  = "${var.aws_region}"
  profile = "helderklemp"
}

/*
* All resources should have the actutal branch as an identifier 
* Thus, this will ensure that master means production and each dev can apply isolated feature branchs
*/
variable "branch" {
  default = "master"
}

resource "aws_vpc" "${var.branch}-vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "aws-${var.branch}-vpc"
  }
}
