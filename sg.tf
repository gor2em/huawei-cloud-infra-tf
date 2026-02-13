# Security Group for RDS SQL Server Start
resource "huaweicloud_networking_secgroup" "rds_sqlserver" {
  name        = "${var.env}-${var.app_name}-${var.svc["sg"]}-rds-sqlserver"
  description = "Security group for RDS SQL Server - allows internal VPC access on port 1433"
  tags        = var.default_tags
}

resource "huaweicloud_networking_secgroup_rule" "rds_sqlserver_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1433
  port_range_max    = 1433
  remote_ip_prefix  = var.vpc_cidr
  security_group_id = huaweicloud_networking_secgroup.rds_sqlserver.id
  description       = "Allow SQL Server access from VPC"
}
############################################################################# Security Group for RDS SQL Server End

# Security Group for DDS MongoDB Start
resource "huaweicloud_networking_secgroup" "dds_mongodb" {
  name        = "${var.env}-${var.app_name}-${var.svc["sg"]}-dds-mongodb"
  description = "Security group for DDS MongoDB - allows internal VPC access on port 8635"
  tags        = var.default_tags
}

resource "huaweicloud_networking_secgroup_rule" "dds_mongodb_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8635
  port_range_max    = 8635
  remote_ip_prefix  = var.vpc_cidr
  security_group_id = huaweicloud_networking_secgroup.dds_mongodb.id
  description       = "Allow MongoDB access from VPC"
}
############################################################################# Security Group for DDS MongoDB End
