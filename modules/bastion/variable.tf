variable "name"            {}
variable "vpc_id"          {}
variable "subnets"         {}
variable "instance_type"   { default = "m3.medium" }
variable "image_id"        { default = "ami-4e82fc2e" }
variable "security_groups" { default = "" }
variable "spot_price"      { default = "" }
variable "key_name"        { default = "" }
variable "template"        { default = "" }
variable "zone_id"         { default = "" }
variable "trusted_cidrs"   { default = "" }
