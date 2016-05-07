resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.main.id}"
  count                   = "${length(split(",", var.availability_zones))}"
  cidr_block              = "${cidrsubnet(var.cidr_block, var.subnet_bits, count.index)}"
  availability_zone       = "${var.region}${element(split(",", var.availability_zones), count.index)}"
  map_public_ip_on_launch = 1
  tags {
    Name = "${var.name}-public-${count.index}"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.main.id}"
  count                   = "${length(split(",", var.availability_zones))}"
  cidr_block              = "${cidrsubnet(var.cidr_block, var.subnet_bits, count.index + 10)}"
  availability_zone       = "${var.region}${element(split(",", var.availability_zones), count.index)}"
  map_public_ip_on_launch = 0
  tags {
    Name = "${var.name}-private-${count.index}"
  }
}
