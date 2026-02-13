# AK/SK for Huawei Cloud Start
variable "access_key" {
  description = "Huawei Cloud access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Huawei Cloud secret key"
  type        = string
  sensitive   = true
}
############################################################################# AK/SK for Huawei Cloud End

# Environment & General Settings Start
variable "env" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "app_name" {
  description = "Application name"
  type        = string
}

variable "region" {
  description = "Huawei Cloud region (e.g., tr-west-1)"
  type        = string
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
}

variable "svc" {
  description = "Service abbreviations for naming"
  type        = map(string)
}
############################################################################ Environment & General Settings End


# Billing Mode Start (charge_mode = Billing mode, eip_charge_mode = EIP Billing mode)
variable "charge_mode" {
  description = <<EOT
Global charge mode applied to all services that support billing options.
- "postPaid"  = pay-per-use
- "prePaid"   = subscription
EOT
  type        = string
  default     = "postPaid"
}

variable "eip_charge_mode" {
  description = "Default bandwidth charge mode"
  type        = string
  default     = "traffic"
}
############################################################################# Billing Mode End

# EIP Start (EIP related variables)
variable "eip_type" {
  description = "EIP line type (e.g., 5_bgp, 5_union, 5_telcom, 5_mobile)"
  type        = string
  default     = "5_bgp"
}

variable "eip_share_type" {
  description = "EIP bandwidth share type: PER (dedicated) or WHOLE (shared)"
  type        = string
  default     = "PER"
}

variable "eip_bandwidth_size" {
  description = "Default bandwidth size (Mbit/s) for all EIPs"
  type        = number
  default     = 300
}

// Creating by default 3 EIPs: nat, elb (ingress), cce
variable "eips" {
  description = "EIP resources to create"
  type        = map(string)
}
############################################################################ EIP End

# VPC and Subnets Start
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnets" {
  description = "Map of subnets keyed by name; each { cidr, az }"
  type = map(object({
    cidr = string
    az   = string
  }))
}
############################################################################# VPC and Subnets End

# Nat Gateway Start
variable "nat_spec" {
  description = "NAT Gateway spec (1=small, 2=medium, 3=large, 4=xl)"
  type        = number
  default     = 1
}
############################################################################# Nat Gateway End

# CCE K8s Start
variable "cce_version" {
  description = "CCE cluster version (e.g., v1.30)"
  type        = string
  default     = "v1.31" // Optional, String, ForceNew) Specifies the cluster version, defaults to the latest supported version. Changing this parameter will create a new cluster resource.
}

variable "cce_flavor_id" {
  description = "CCE cluster flavor ID (e.g., cce.s1.small, cce.s1.medium, cce.s1.large)"
  type        = string
  default     = "cce.s1.small"
  // Flavor ID options:  https://registry.terraform.io/providers/huaweicloud/hcso/latest/docs/resources/cce_cluster
}

variable "cce_network_type" {
  description = "Container network type: overlay_l2, underlay, eni"
  type        = string
  default     = "eni" // VPC-CNI mode
}
############################################################################ CCE K8s End

# CCE Nodepool Start
variable "nodepools" {
  description = "CCE node pools config"
  type = map(object({
    az          = string
    subnet      = string
    os          = string
    flavor      = string
    count       = number
    password    = string
    volume_type = string
    volume_size = number
  }))
}
########################################################################### Nodepool End

# CCE Addons Start
variable "cce_addons" {
  description = "CCE addons to install (name and version)" # 3.0.34 for v1.31
  type = list(object({
    name    = string
    version = string
  }))
}
########################################################################### ECS Instances End

