resource "aws_elb" "external" {
  internal        = false
  subnets         = ["${split(",", var.subnets)}"]
  name            = "${var.name}"
  security_groups = ["${aws_security_group.load_balancer.id}"]
  idle_timeout    = 3600
  lifecycle { create_before_destroy = true }

  listener {
    instance_port     = 22
    instance_protocol = "tcp"
    lb_port           = 22
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:22"
    interval            = 15
  }
}
