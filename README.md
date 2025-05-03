AWS 3-Tier Web Application using Terraform

This project demonstrates how to deploy a production-like 3-tier web application architecture on AWS using Terraform. It includes networking, compute, and database layers along with proper security and routing configurations.

**Architecture Overview**

3-Tier Setup:

- Frontend: Static website (served via EC2)
- Backend: Node.js app running on EC2
- Database: Amazon RDS (MySQL)

Networking:

- Custom VPC with:
  - Public subnets (for Load Balancer, Frontend EC2, and NAT Gateway)
  - Private subnets (for Backend EC2 and RDS)
- Internet Gateway for public access
- NAT Gateway for outbound access from private subnets

Security:

- Load Balancer SG: open on ports 80 and 443
- Backend EC2 SG: allows traffic only from Load Balancer on port 3000
- RDS SG: allows traffic only from Backend EC2 on port 3306

Project Structure:

- provider.tf         - AWS provider and backend configuration

- vpc.tf              - VPC, subnets, IGW, NAT Gateway, route tables

- sg.tf               - Security groups for each tier

- ec2_fe.tf           - Frontend EC2 instance configuration

- ec2_be.tf           - Backend EC2 instance configuration (Node.js app)

- rds.tf              - RDS MySQL instance configuration

- var.tf              - Input variables


Deployment Steps:


Initialize Terraform - **terraform init**

Review the execution plan - **terraform plan**

Apply the configuration - **terraform apply**

Destroy the infrastructure (when no longer needed) - **terraform destroy**


✅ Prerequisites

- Terraform installed

- AWS CLI configured (aws configure)

- AWS account with required permissions (EC2, VPC, RDS, IAM)

📦 Features

- Fully functional 3-tier architecture

- Proper isolation with public/private subnets

- Secure connectivity between application layers

