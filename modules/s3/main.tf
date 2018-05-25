provider "aws" {
  region  = "${var.aws_region}"
  profile = "cmdlab"
}

resource "aws_s3_bucket" "helderklemp" {
  bucket = "helderklemp-${var.branch}"
  acl    = "private"

  tags {
    Name = "helderklemp-${var.branch}"
  }
}
