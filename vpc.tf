# VPC Start
resource "huaweicloud_vpc" "this" {
  name = "${var.env}-${var.app_name}-${var.svc["vpc"]}"
  cidr = var.vpc_cidr
  tags = var.default_tags
}
############################################################################# VPC End

# Subnets Start
resource "huaweicloud_vpc_subnet" "this" {
  for_each          = var.subnets
  name              = "${var.env}-${var.app_name}-${var.svc["subnet"]}-${each.key}"
  vpc_id            = huaweicloud_vpc.this.id
  cidr              = each.value.cidr
  availability_zone = each.value.az
  gateway_ip        = cidrhost(each.value.cidr, 1)
  tags              = var.default_tags
}
############################################################################# Subnets End