resource "aws_security_group_rule" "allow_all" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["${compact(split(",", var.trusted_cidrs))}"]
  security_group_id = "${aws_vpc.main.default_security_group_id}"
}
