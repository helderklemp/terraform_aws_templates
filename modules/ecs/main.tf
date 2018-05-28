/*resource "aws_ecs_task_definition" "helderklemp" {
  family = "helderklemp-${var.branch}"

  container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "environment": [{
      "name": "SECRET",
      "value": "KEY"
    }],
    "essential": true,
    "image": "helderklemp/pythons_rest_app:latest",
    "memory": 128,
    "memoryReservation": 64,
    "name": "pythons_rest_app"
  }
]
DEFINITION
}*/

resource "aws_ecs_cluster" "main" {
  name = "${var.ecs_cluster_name}-${var.branch}"
}

/*
resource "aws_ecs_service" "helderklemp" {
  name            = "helderklemp-${var.branch}"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.helderklemp.arn}"
  desired_count   = 3
  iam_role        = "${aws_iam_role.ecs_runner.arn}"
  depends_on      = ["aws_iam_role_policy.ecs_runner"]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = "${aws_lb_target_group.foo.arn}"
    container_name   = "mongo"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}*/

