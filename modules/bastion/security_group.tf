resource "aws_security_group" "load_balancer" {
  name        = "${var.name}-elb"
  description = "${var.name}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group" "instance" {
  name        = "${var.name}"
  description = "${var.name}"
  vpc_id      = "${var.vpc_id}"
}

resource "aws_security_group_rule" "egress_load_balancer_to_bastion" {
  type        = "egress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  security_group_id        = "${aws_security_group.load_balancer.id}"
  source_security_group_id = "${aws_security_group.instance.id}"
}

resource "aws_security_group_rule" "ingress_load_balancer_to_bastion" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  security_group_id        = "${aws_security_group.instance.id}"
  source_security_group_id = "${aws_security_group.load_balancer.id}"
}

resource "aws_security_group_rule" "ingress_trusted_cidrs_to_load_balancer" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  security_group_id = "${aws_security_group.load_balancer.id}"
  cidr_blocks       = ["${compact(split(",", var.trusted_cidrs))}"]
}
