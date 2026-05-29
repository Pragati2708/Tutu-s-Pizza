# Tutu's Pizza - Enterprise DevSecOps CI/CD Pipeline on AWS

## 📖 Project Overview

Tutu's Pizza is a cloud-native React application deployed on AWS using modern DevOps and DevSecOps practices.

The project demonstrates end-to-end automation, Infrastructure as Code (IaC), containerization, security scanning, and zero-downtime deployments through a fully automated CI/CD pipeline.

---

## 🚀 Architecture

GitHub → CodePipeline → CodeBuild → SonarQube Scan → Docker Build → Trivy Scan → Amazon ECR → CodeDeploy → ECS Fargate → Application Load Balancer

---

# Architecture Decisions

## Why Terraform?

Terraform was used to provision AWS infrastructure as code instead of manually creating resources through the AWS Console.

Benefits:

* Repeatable infrastructure deployments
* Version-controlled infrastructure
* Reduced configuration drift
* Faster environment provisioning
* Easier disaster recovery

---

## Why Docker?

Docker was used to containerize the React application and ensure consistency across environments.

Benefits:

* Consistent runtime environment
* Easier deployment
* Improved portability
* Simplified dependency management

---

## Why Amazon ECS Fargate?

Amazon ECS Fargate was chosen over managing EC2 instances because it provides a serverless container platform.

Benefits:

* No server management
* Automatic scaling
* Reduced operational overhead
* Better integration with AWS services

---

## Why AWS CodePipeline Instead of GitHub Actions or Jenkins?

### GitHub Actions

GitHub Actions could have been used for CI/CD. However, the objective of this project was to build a cloud-native AWS DevSecOps platform using managed AWS services.

Advantages of CodePipeline:

* Native integration with ECS, ECR, CodeBuild, and CodeDeploy
* Centralized AWS deployment workflow
* Reduced external dependencies
* Better AWS ecosystem integration

### Jenkins

Jenkins is powerful and widely used but requires managing infrastructure, plugins, upgrades, backups, and security.

Reasons for choosing AWS CodePipeline:

* Fully managed service
* Lower operational overhead
* No Jenkins server maintenance
* Easier integration with AWS services

---

## Why AWS CodeDeploy?

AWS CodeDeploy was selected because the project implements Blue-Green deployments on ECS.

Benefits:

* Zero-downtime deployments
* Automated traffic shifting
* Safer production releases
* Quick rollback capability

CodeDeploy works directly with:

* ECS
* Application Load Balancer
* Target Groups

making Blue-Green deployment implementation much simpler and more reliable.

---

## Why SonarQube?

SonarQube was integrated to introduce automated code quality and security analysis.

Benefits:

* Detects code smells
* Identifies security vulnerabilities
* Improves maintainability
* Provides quality gates

---

## Why Trivy?

Trivy was used to scan Docker images for vulnerabilities before deployment.

Benefits:

* Detects CVEs
* Scans operating system packages
* Scans application dependencies
* Enhances container security

---

## Why Ansible?

Terraform creates infrastructure.

Ansible configures infrastructure.

In this project, Ansible was used to:

* Install Docker on the SonarQube server
* Configure services
* Deploy SonarQube automatically

This separation follows industry best practices.

Terraform = Provision Infrastructure

Ansible = Configure Infrastructure

---

# Repository Structure

terraform/
├── main.tf
├── variables.tf
├── outputs.tf

ansible/
├── inventory
├── sonar-playbook.yml

src/
├── React application source code

buildspec.yml
Dockerfile
appspec.yml
README.md

---

# How to Run This Project

## Prerequisites

* AWS Account
* Terraform
* Docker
* AWS CLI
* Git
* Ansible

---

## Clone Repository

git clone <repository-url>

cd Tutu-s-Pizza

---

## Deploy Infrastructure

cd terraform

terraform init

terraform plan

terraform apply

---

## Configure SonarQube

cd ../ansible

ansible-playbook -i inventory sonar-playbook.yml

---

## Configure CI/CD

1. Create ECR Repository
2. Create CodeBuild Project
3. Create CodePipeline
4. Configure CodeDeploy
5. Configure GitHub Connection

---

## Trigger Deployment

git add .

git commit -m "Deploy application"

git push

Pipeline automatically performs:

* SonarQube Scan
* Docker Build
* Trivy Scan
* ECR Push
* Blue-Green Deployment

---

# Future Enhancements

* Kubernetes (EKS)
* Prometheus Monitoring
* Grafana Dashboards
* ArgoCD GitOps
* AWS Secrets Manager
* Automated Rollback Policies
* Slack Notifications

---

# Key Learnings

* Infrastructure as Code with Terraform
* Containerization with Docker
* CI/CD Automation
* Blue-Green Deployment Strategy
* DevSecOps Security Integration
* AWS Cloud-Native Architecture
* Configuration Management with Ansible
* Troubleshooting IAM, ECS, and Deployment Issues

## 📷 Project Screenshots

* AWS CodePipeline Success
* AWS CodeBuild Success
* SonarQube Dashboard
* Trivy Scan Results
* ECS Service Running
* Application Load Balancer
* Live Application

---

## 👩‍💻 Author

Pragati Singh

DevOps Engineer | AWS | Terraform | Docker | Kubernetes | CI/CD | DevSecOps
