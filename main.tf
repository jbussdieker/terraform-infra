module "vpc" {
  source             = "modules/vpc"
  name               = "${var.name}"
  region             = "${var.region}"
  cidr_block         = "${var.cidr_block}"
  subnet_bits        = "${var.subnet_bits}"
  availability_zones = "${var.availability_zones}"
  trusted_cidrs      = "${var.trusted_cidrs}"
}

module "bastion" {
  source             = "modules/cluster"
  name               = "bastion"
  template           = "salt-minion"
  subnets            = "${module.vpc.public_subnets}"
  security_groups    = "${module.vpc.default_security_group}"
  instance_type      = "m3.medium"
  spot_price         = "0.012"
  key_name           = "${var.key_name}"
}

module "salt-master" {
  source             = "modules/cluster"
  name               = "salt-master"
  template           = "salt-master"
  subnets            = "${module.vpc.private_subnets}"
  security_groups    = "${module.vpc.default_security_group}"
  instance_type      = "m3.medium"
  spot_price         = "0.012"
  key_name           = "${var.key_name}"
}

module "monitoring" {
  source             = "modules/cluster"
  name               = "monitoring"
  template           = "salt-minion"
  subnets            = "${module.vpc.private_subnets}"
  security_groups    = "${module.vpc.default_security_group}"
  instance_type      = "m3.medium"
  spot_price         = "0.012"
  key_name           = "${var.key_name}"
}

module "stats" {
  source             = "modules/cluster"
  name               = "stats"
  template           = "salt-minion"
  subnets            = "${module.vpc.private_subnets}"
  security_groups    = "${module.vpc.default_security_group}"
  instance_type      = "m3.medium"
  spot_price         = "0.012"
  key_name           = "${var.key_name}"
}

module "logs" {
  source             = "modules/cluster"
  name               = "logs"
  template           = "salt-minion"
  subnets            = "${module.vpc.private_subnets}"
  security_groups    = "${module.vpc.default_security_group}"
  instance_type      = "m3.medium"
  spot_price         = "0.012"
  key_name           = "${var.key_name}"
}
