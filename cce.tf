# CCE Cluster Start
resource "huaweicloud_cce_cluster" "this" {
  name                   = "${var.env}-${var.app_name}-${var.svc["cce"]}"
  cluster_type           = "VirtualMachine"
  flavor_id              = var.cce_flavor_id
  vpc_id                 = huaweicloud_vpc.this.id
  subnet_id              = huaweicloud_vpc_subnet.this["node"].id
  container_network_type = var.cce_network_type
  eni_subnet_id          = huaweicloud_vpc_subnet.this["pod"].ipv4_subnet_id
  eip                    = huaweicloud_vpc_eip.this["cce"].address
  tags                   = var.default_tags

  depends_on = [huaweicloud_vpc_subnet.this]
}
############################################################################# CCE Cluster End

# CCE Node Pools Start
resource "huaweicloud_cce_node_pool" "this" {
  for_each = var.nodepools

  cluster_id         = huaweicloud_cce_cluster.this.id
  name               = "${var.env}-${var.app_name}-${each.key}"
  os                 = each.value.os
  initial_node_count = each.value.count
  flavor_id          = each.value.flavor
  type               = "vm"
  availability_zone  = each.value.az
  password           = each.value.password
  charging_mode      = var.charge_mode
  subnet_id          = huaweicloud_vpc_subnet.this[each.value.subnet].id
  tags               = var.default_tags

  root_volume {
    size       = 40
    volumetype = "SAS"
  }

  data_volumes {
    size       = each.value.volume_size
    volumetype = each.value.volume_type
  }

  depends_on = [huaweicloud_cce_cluster.this]
}
############################################################################# CCE Node Pools End

# # CCE Addons Start (commented out ingress as per requirements)
# # resource "huaweicloud_cce_addon" "this" {
# #   for_each      = { for addon in var.cce_addons : addon.name => addon }
# #   cluster_id    = huaweicloud_cce_cluster.this.id
# #   template_name = each.value.name
# #   version       = each.value.version
# #
# #   values {
# #     basic_json = "{}"
# #
# #     # Special case: nginx-ingress needs ELB annotation
# #     custom_json = each.value.name == "nginx-ingress" ? jsonencode({
# #       "service" = {
# #         "annotations" = {
# #           "kubernetes.io/elb.id" = huaweicloud_lb_loadbalancer.this.id
# #         }
# #       }
# #       "resources" = {
# #         "limits" = {
# #           "cpu"    = "128m"
# #           "memory" = "256Mi"
# #         }
# #         "requests" = {
# #           "cpu"    = "128m"
# #           "memory" = "128Mi"
# #         }
# #       }
# #     }) : "{}"
# #   }
# #
# #   depends_on = [huaweicloud_cce_cluster.this]
# # }
# ############################################################################# CCE Addons End
