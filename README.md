# Terraform Infrastructure - Ne Yapıyor?

Bu Terraform konfigürasyonu Huawei Cloud üzerinde CCE (Kubernetes) altyapısı kuruyor.

## 🔧 Kurulum Adımları

### 1. **VPC ve Network** (`vpc.tf`)
- 1 VPC oluşturur (`10.0.0.0/16`)
- 3 subnet oluşturur:
  - `subnet-node`: Node'lar için (`10.0.1.0/24`)
  - `subnet-pod`: Pod'lar için (`10.0.2.0/24`)
  - `subnet-data`: Database/ELB için (`10.0.3.0/24`)

### 2. **Elastic IP'ler** (`eips.tf`)
- 3 public IP oluşturur:
  - NAT Gateway için
  - ELB için (elastic IP)
  - CCE API endpoint için

### 3. **NAT Gateway** (`nat.tf`)
- NAT Gateway kurar (small)
- 3 subnet için SNAT kuralları ekler
- Tüm subnet'ler internete çıkabilir

### 4. **Load Balancer** (`elb.tf`)
- L4 TCP Layer ELB oluşturur
- Elastic (dedicated) IP ile
- Ingress trafiği için hazır

### 5. **Security Groups** (`sg.tf`)
- RDS SQL Server SG (port 1433, VPC içi)
- DDS MongoDB SG (port 8635, VPC içi)

### 6. **CCE Kubernetes Cluster** (`cce.tf`)
- CCE cluster kurar (v1.33)
- VPC-CNI networking (ENI mode)
- 2 node pool oluşturur:
  - **application**: 2 node (SAS storage)
  - **stateful**: 3 node (GPSSD storage)
- Tümü: Ubuntu 22.04, Flexus x1.4u.16g (4vCPU/16GB)

## 📤 Outputs

Kurulum sonunda şunları verir:
- VPC, subnet, EIP ID'leri (NAT, CCE)
- NAT Gateway ID
- ELB ID ve IP'leri (elastic public IP)
- CCE cluster ID
- Node pool ID'leri (application, stateful)
- Security Group ID'leri

## 🚀 Kullanım

```bash
terraform init      # Provider'ları indir
terraform plan      # Değişiklikleri gör (AK/SK sorulacak)
terraform apply     # Uygula (AK/SK sorulacak)
```

## 📋 Özet

**Oluşturulan Kaynaklar:**
- 1 VPC + 3 Subnet
- 3 Elastic IP (NAT, ELB, CCE)
- 1 NAT Gateway + 3 SNAT kuralı
- 1 Load Balancer (L4, elastic IP)
- 2 Security Group
- 1 CCE Cluster + 2 Node Pool (toplam 5 node: 2+3)

**Toplam maliyet:** Pay-as-you-go (postPaid) modunda, kullandığın kadar öde.
