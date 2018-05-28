provider "aws" {
  region = "${var.aws_region}"

  assume_role {
    role_arn     = "arn:aws:iam::${var.aws_account}:role/${var.aws_role_name}"
    session_name = "terraform_client"
    external_id  = "${var.aws_external_id}"
  }
}
