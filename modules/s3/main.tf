resource "aws_s3_bucket" "helderklemp" {
  bucket = "helderklemp-${var.branch}"
  acl    = "private"

  tags {
    Name = "helderklemp-${var.branch}"
  }
}
