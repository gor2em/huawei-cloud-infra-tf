// --- VPC & Subnets ---
output "vpc_id" {
  description = "VPC ID"
  value       = huaweicloud_vpc.this.id
}

output "subnet_ids" {
  description = "Subnet IDs by key"
  value       = { for k, s in huaweicloud_vpc_subnet.this : k => s.id }
}

output "subnet_ipv4_ids" {
  description = "IPv4 subnet IDs by key (used by ELB/CCE)"
  value       = { for k, s in huaweicloud_vpc_subnet.this : k => s.ipv4_subnet_id }
}

// --- Elastic IPs ---
output "eip_ids" {
  description = "EIP resource IDs by purpose"
  value       = { for k, e in huaweicloud_vpc_eip.this : k => e.id }
}

output "eip_addresses" {
  description = "EIP addresses by purpose"
  value       = { for k, e in huaweicloud_vpc_eip.this : k => e.address }
}

output "eip_elb_address" {
  description = "Elastic IP attached to ELB"
  value       = try(huaweicloud_vpc_eip.this["elb"].address, null)
}

output "eip_nat_address" {
  description = "Public IP used by NAT Gateway SNAT"
  value       = try(huaweicloud_vpc_eip.this["nat"].address, null)
}

output "eip_cce_address" {
  description = "Public IP attached to the CCE API endpoint"
  value       = try(huaweicloud_vpc_eip.this["cce"].address, null)
}

// --- NAT Gateway ---
output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = huaweicloud_nat_gateway.this.id
}

output "nat_snat_rule_ids" {
  description = "SNAT Rule IDs for all subnets"
  value       = { for k, r in huaweicloud_nat_snat_rule.this : k => r.id }
}

// --- ELB ---
output "elb_id" {
  description = "Ingress ELB ID"
  value       = huaweicloud_elb_loadbalancer.this.id
}

output "elb_vip_address" {
  description = "Ingress ELB VIP address (private)"
  value       = huaweicloud_elb_loadbalancer.this.ipv4_address
}

output "elb_vip_port_id" {
  description = "Ingress ELB VIP port ID"
  value       = huaweicloud_elb_loadbalancer.this.ipv4_port_id
}

output "elb_public_ip" {
  description = "Ingress ELB Public IP"
  value       = huaweicloud_vpc_eip.this["elb"].address
}

// --- CCE Cluster ---
output "cce_cluster_id" {
  description = "CCE cluster ID"
  value       = huaweicloud_cce_cluster.this.id
}

output "cce_cluster_name" {
  description = "CCE cluster name"
  value       = huaweicloud_cce_cluster.this.name
}

// --- CCE Node Pools ---
output "nodepool_ids" {
  description = "CCE Node Pool IDs"
  value       = { for k, np in huaweicloud_cce_node_pool.this : k => np.id }
}

// --- Security Groups ---
output "sg_rds_sqlserver_id" {
  description = "Security Group ID for RDS SQL Server"
  value       = huaweicloud_networking_secgroup.rds_sqlserver.id
}

output "sg_dds_mongodb_id" {
  description = "Security Group ID for DDS MongoDB"
  value       = huaweicloud_networking_secgroup.dds_mongodb.id
}

// --- OBS ---
output "obs_bucket_name" {
  description = "OBS bucket name"
  value       = huaweicloud_obs_bucket.this.bucket
}

output "obs_bucket_id" {
  description = "OBS bucket ID"
  value       = huaweicloud_obs_bucket.this.id
}
