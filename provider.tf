// Terraform core + HuaweiCloud provider configuration
terraform {
  required_version = ">= 1.4.0"

  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = ">= 1.56.0"
    }
  }
}

// Huawei Cloud provider configuration
provider "huaweicloud" {
  region = var.region

  # Access credentials: prefer environment variables (HW_ACCESS_KEY / HW_SECRET_KEY)
  access_key = var.access_key
  secret_key = var.secret_key
}
