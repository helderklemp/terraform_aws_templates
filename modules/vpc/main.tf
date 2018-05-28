resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "aws-${var.branch}-vpc"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "aws-${var.branch}-internet-gateway"
  }
}

/*
  NAT Instance
*/
resource "aws_security_group" "nat" {
  name        = "vpc_nat-${var.branch}"
  description = "Allow traffic to pass from the private subnet to the internet"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.private_subnet_cidr}"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "NATSG-${var.branch}"
  }
}

resource "aws_instance" "nat" {
  ami                         = "ami-30913f47"                   # this is a special ami preconfigured to do NAT
  availability_zone           = "${var.aws_region}"
  instance_type               = "m1.small"
  vpc_security_group_ids      = ["${aws_security_group.nat.id}"]
  subnet_id                   = "${aws_subnet.public.0.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  tags {
    Name = "VPC-NAT-${var.branch}"
  }
}

resource "aws_eip" "nat" {
  instance = "${aws_instance.nat.id}"
  vpc      = true

  tags {
    Name = "NAT-EIP-${var.branch}"
  }
}

/*
  Public Subnet
*/
resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.default.id}"
  count             = "${length(var.availability_zones)}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "DMZ-${var.branch}-${element(var.availability_zones, count.index)}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"
  count  = "${length(var.availability_zones)}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name = "Public Subnet-${var.branch}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}

/*
  Private Subnet
*/
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.default.id}"
  count             = "${length(var.availability_zones)}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags {
    Name = "PRIVATE-${var.branch}-${element(var.availability_zones, count.index)}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.default.id}"
  count  = "${length(var.availability_zones)}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }

  tags {
    Name = "Private Subnet-${var.branch}"
  }
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
