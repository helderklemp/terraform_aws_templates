output "vpc_detail" {
  value = "${data.aws_vpc.selected.id}"
}
