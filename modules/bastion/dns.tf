resource "aws_route53_record" "external" {
  name    = "${var.name}"
  type    = "CNAME"
  ttl     = "60"
  zone_id = "${var.zone_id}"
  records = ["${aws_elb.external.dns_name}"]
}
