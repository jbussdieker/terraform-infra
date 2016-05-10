module "template" {
  source   = "../bootstrap"
  template = "${var.template}"
  name     = "${var.name}"
}

resource "aws_launch_configuration" "main" {
  instance_type   = "${var.instance_type}"
  image_id        = "${var.image_id}"
  name_prefix     = "${var.name}-"
  spot_price      = "${var.spot_price}"
  key_name        = "${var.key_name}"
  user_data       = "${module.template.rendered}"
  security_groups = [
    "${compact(split(",", var.security_groups))}",
    "${aws_security_group.instance.id}"
  ]
}

resource "aws_autoscaling_group" "main" {
  name                      = "${var.name}"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  health_check_type         = "EC2"
  health_check_grace_period = 300
  launch_configuration      = "${aws_launch_configuration.main.name}"

  load_balancers = [
    "${aws_elb.external.name}"
  ]

  vpc_zone_identifier = [
    "${split(",", var.subnets)}"
  ]

  tag {
    key                 = "Name"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}
