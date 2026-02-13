# NAT Gateway Start
resource "huaweicloud_nat_gateway" "this" {
  name          = "${var.env}-${var.app_name}-${var.svc["nat"]}"
  spec          = var.nat_spec
  vpc_id        = huaweicloud_vpc.this.id
  subnet_id     = huaweicloud_vpc_subnet.this["node"].id
  charging_mode = var.charge_mode
  tags          = var.default_tags
}
############################################################################# NAT Gateway End

# NAT SNAT Rule Start (for all subnets)
resource "huaweicloud_nat_snat_rule" "this" {
  for_each = var.subnets

  nat_gateway_id = huaweicloud_nat_gateway.this.id
  subnet_id      = huaweicloud_vpc_subnet.this[each.key].id
  floating_ip_id = huaweicloud_vpc_eip.this["nat"].id
}
############################################################################# NAT SNAT Rule End