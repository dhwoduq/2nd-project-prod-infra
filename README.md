# 2차 프로젝트 - 운영 환경 인프라 구성 (Terraform 기반)

Terraform을 사용하여 AWS 기반 운영 인프라를 코드로 구축한 프로젝트입니다.  
고가용성과 보안성을 고려하여 운영 환경에 적합한 VPC, Subnet, EC2, NAT Gateway, ALB, Route53 등을 자동화했습니다.

---

## 📌 인프라 구성 요소

| 항목           | 상세 내용 |
|----------------|-----------|
| **VPC**         | CIDR: 10.20.0.0/16 |
| **Subnet**      | Public (2개), Web용 Private (2개), WAS용 Private (2개) |
| **EC2**         | Bastion(2대), Web(2대), WAS(2대), Monitoring(1대) |
| **Load Balancer** | ALB + HTTPS 리스너 (443 포트) |
| **NAT Gateway** | 2개 (AZ 별 구성) |
| **Route53**     | ALB 도메인 연결 |
| **보안 그룹**   | Bastion, Web, WAS, Monitoring 역할별 분리 구성 |

---

## 🗂 디렉토리 구조

<pre>
terraform_prod/
├── main.tf
├── outputs.tf
├── provider.tf
├── terraform.tfvars
├── variables.tf
├── modules/
│   ├── alb/
│   ├── ec2/
│   ├── route53/
│   ├── routing/
│   ├── sg/
│   ├── subnet/
│   └── vpc/
</pre>

---

## 🛠️ 기술 스택

- **Terraform**: IaC (Infrastructure as Code)
- **AWS**: EC2, VPC, ALB, Route53 등
- **Ubuntu 22.04**: EC2 인스턴스 OS
- **Git & GitHub**: 형상 관리 및 버전 관리

---

## 🧪 실행 방법
terraform init
terraform plan
terraform apply

---

## 🙋‍♂️ 작성자

**오재엽(dhwoduq)**  
클라우드 & 시스템 엔지니어 취업 준비생  
🔗 GitHub: [https://github.com/dhwoduq](https://github.com/dhwoduq)
