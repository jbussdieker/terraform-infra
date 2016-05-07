resource "template_file" "main" {
  template = "${file("${path.module}/${var.template}")}"
  lifecycle { create_before_destroy = true }
  vars {
    name = "${var.name}"
  }
}
