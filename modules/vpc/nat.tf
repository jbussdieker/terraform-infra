resource "aws_eip" "nat" {
  count = "${length(split(",", var.availability_zones))}"
  vpc   = true
}

resource "aws_nat_gateway" "nat" {
  count         = "${length(split(",", var.availability_zones))}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
}
