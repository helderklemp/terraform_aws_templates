provider "aws" {
  region = "${var.aws_region}"

  assume_role {
    role_arn     = "${var.role_arn}"
    session_name = "${var.session_name}"
    external_id  = "${var.external_id}"
  }
}

module "ecs" {
  source           = "modules/ecs"
  ecs_cluster_name = "helderklemp-first-cluster"
}
