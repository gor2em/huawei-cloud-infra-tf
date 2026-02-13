# Query elastic L4 flavor (autoscaling specification)
data "huaweicloud_elb_flavors" "l4_elastic" {
  type = "L4_elastic_max"
}

# ELB Start (dedicated elastic load balancer)
resource "huaweicloud_elb_loadbalancer" "this" {
  name           = "${var.env}-${var.app_name}-ingress-${var.svc["elb"]}"
  description    = "Elastic Load Balancer for ${var.env}-${var.app_name}"
  vpc_id         = huaweicloud_vpc.this.id
  ipv4_subnet_id = huaweicloud_vpc_subnet.this["data"].ipv4_subnet_id

  # Elastic specification (LCU-based billing, autoscaling)
  # Use UUID from data source, not flavor name
  l4_flavor_id = data.huaweicloud_elb_flavors.l4_elastic.ids[0]

  availability_zone = ["${var.region}a"]

  ipv4_eip_id = huaweicloud_vpc_eip.this["elb"].id

  tags = var.default_tags

  depends_on = [huaweicloud_vpc_subnet.this, huaweicloud_vpc_eip.this]
}
############################################################################# ELB End
