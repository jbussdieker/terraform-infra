variable "name"               { default = "main" }
variable "region"             { default = "us-west-1" }
variable "cidr_block"         { default = "10.0.0.0/16" }
variable "subnet_bits"        { default = "8" }
variable "availability_zones" { default = "a,b" }
variable "trusted_cidrs"      { default = "" }
variable "key_name"           { default = "" }
