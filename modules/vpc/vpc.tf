resource "aws_vpc" "main" {
  cidr_block           = "${var.cidr_block}"
  enable_classiclink   = 0
  enable_dns_hostnames = 1
  enable_dns_support   = 1
  tags {
    Name = "${var.name}"
  }
}
