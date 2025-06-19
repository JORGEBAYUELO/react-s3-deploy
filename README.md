# 🚀 React App CI/CD Pipeline with AWS S3 + CloudFront + GitHub Actions + Terraform + WAF

This project demonstrates a **real-world, production-ready DevOps CI/CD pipeline** for deploying a React application to AWS infrastructure using Terraform and GitHub Actions. The infrastructure is hardened using **WAF (Web Application Firewall)**, includes **rollback mechanisms**, and follows **AWS security best practices** (IAM roles, secret management with SSM).

---

## 📌 Table of Contents

- [🎯 Project Goals](#-project-goals)
- [🧱 Architecture Overview](#-architecture-overview)
- [🛠 Tech Stack](#-tech-stack)
- [🚀 Features Implemented](#-features-implemented)
- [📂 Folder Structure](#-folder-structure)
- [⚙️ Setup Instructions](#️-setup-instructions)
  - [1. Terraform Infrastructure Setup](#1-terraform-infrastructure-setup)
  - [2. React App Deployment via GitHub Actions](#2-react-app-deployment-via-github-actions)
- [🔐 Security Hardening](#-security-hardening)
- [🔄 Rollback Automation](#-rollback-automation)
- [💥 Cleanup](#-cleanup)
- [🧠 Lessons Learned](#-lessons-learned)


---

## 🎯 Project Goals

-  Automate deployment of a React app using **GitHub Actions**
-  Provision secure, reproducible AWS infrastructure using **Terraform**
-  Apply real-world DevOps practices: **CI/CD**, **IaC**, **security**, **monitoring**
-  Stay within the **AWS Free Tier**


---

## 🧱 Architecture Overview

![Architecture Diagram](/cicdpipeline.png)


---

## 🛠 Tech Stack

| Tool                        | Purpose                           |
| --------------------------- | --------------------------------- |
| **React + Tailwind**        | Frontend static application       |
| **Terraform**               | Infrastructure provisioning (IaC) |
| **AWS S3**                  | Static file hosting               |
| **AWS CloudFront**          | CDN for global caching            |
| **GitHub Actions**          | CI/CD pipeline automation         |
| **AWS WAFv2**               | Security: managed web ACL rules   |
| **AWS SSM Parameter Store** | Secure secret management          |

---

## 🚀 Features Implemented

-  ✅ Secure S3 bucket for static hosting
-  ✅ CloudFront CDN integration
-  ✅ GitHub Actions CI/CD pipeline
-  ✅ AWS WAF ACL for protection using managed rule sets
-  ✅ IAM user for deployment with least privilege
-  ✅ Rollback strategy using versioned S3 buckets
-  ✅ Terraform `destroy` cleanup routine


---

## 📂 Folder Structure

react-s3-deploy/
├── project/ # React project folder
	├── dist/ # React build output
	├── public/ # Public static files  
	├── src/ # React source files  
├── .github/ # GitHub Actions pipeline
	├── workflows/
		├── deploy.yml # Deploy file
├──	terraform/  
	├── main.tf # Terraform infrastructure code  
	├── waf.tf # WAF ACL config  
	├── variables.tf # Terraform variables  
	├── outputs.tf # Outputs (S3 bucket, CloudFront ID)  
	├── provider.tf # AWS provider configuration
├── .gitignore # Ignores .terraform/ etc.


---

## ⚙️ Setup Instructions

### **1. Terraform Infrastructure Setup**

1. ✅ Install [Terraform](https://www.terraform.io/downloads) and [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

2. ✅ Configure your AWS credentials with a named profile:

```bash
aws configure --profile default
```

3. ✅ Clone the repository:

```bash
git clone https://github.com/JORGEBAYUELO/react-s3-deploy
cd terraform/
```

4. ✅ Initialize Terraform:

```bash
terraform init
```

5. ✅ Modify variables in `variables.tf` as needed:

```hcl
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_profile" {
  default = "default"
}
```

6. ✅ Deploy the infrastructure:

```bash
terraform apply
```

7. ✅ Upload initial `index.html` (optional) and test public URL from CloudFront output.

8. ✅ Run this command to store the CloudFront distribution ID into AWS SSM (used by CI/CD):

```bash
aws ssm put-parameter \
  --name "/devops/react-app/cloudfront_distribution_id" \
  --value "<YOUR_DISTRIBUTION_ID>" \
  --type "String" \
  --overwrite
```

### **2. React App Deployment via GitHub Actions**

1. ✅ Place your React app in the `project/` folder.

2. ✅ Add build output to `project/dist` with:

```bash
cd project/
npm install
npm run build
```

3. ✅ Set GitHub Secrets for your repo:

| Secret Name             | Value         |
| ----------------------- | ------------- |
| `AWS_ACCESS_KEY_ID`     | From IAM user |
| `AWS_SECRET_ACCESS_KEY` | From IAM user |
| `AWS_REGION`            | `us-east-1`   |
4. ✅ Push your code to `main` branch. This will trigger the GitHub Actions pipeline defined in `deploy.yml`.


---

## **🔐 Security Hardening**

-  ✅ No hardcoded secrets — all AWS credentials stored in GitHub Secrets
-  ✅ SSM Parameter Store used for dynamic CloudFront IDs
-  ✅ WAFv2 Web ACL protects from common web exploits
-  ✅ IAM user has minimal permissions (S3, CloudFront, SSM only)


---

## **🔄 Rollback Automation**

if deployment fails:

-  ✅ S3 versioning allows you to **restore previous versions**
-  ✅ You can add a manual step to restore the latest working version
-  ✅ Future enhancement: automatic rollback on pipeline failure (version pinning)


---

## **💥 Cleanup**

To avoid costs:

```bash
terraform destroy
```

This command **removes all provisioned AWS resources** except your IAM deployment user and SSM parameter (which do not incur charges).

Manually remove the SSM parameter if desired:

```bash
aws ssm delete-parameter \
  --name "/devops/react-app/cloudfront_distribution_id"
```


---

## **🧠 Lessons Learned**

-  Built secure, modular, production-grade infrastructure using **Terraform**
-  Deployed a real React app using **CI/CD best practices**
-  Hardened environment with **WAF**, **IAM**, and **secret management**
-  Learned how to debug CloudFront + WAF ARN quirks in a real-world context
-  All infrastructure and automation work is AWS Free Tier–compliant


---

## **📸 Screenshot**

![Web Application Live](/screenshot.png)

---
## **📫 Contact**

This project was developed by [Jorge Bayuelo](https://github.com/JORGEBAYUELO).  
Feel free to connect with me on [LinkedIn](https://www.linkedin.com/in/jorge-bayuelo/)!