---

# 🚀 End-to-End DevOps Project — Jenkins, EKS, ArgoCD, Prometheus, Grafana

## 📜 Overview

This project demonstrates an end-to-end CI/CD pipeline deployed on AWS, with:

* Terraform-based infrastructure provisioning
* Jenkins for CI/CD
* SonarQube, OWASP Dependency Check, Trivy for code quality & security scanning
* Amazon EKS for Kubernetes cluster hosting
* ArgoCD for GitOps-based CD
* Prometheus & Grafana for monitoring

---

## 🛠 Tech Stack

| Tool                                                                                                                       | Purpose                 |
| -------------------------------------------------------------------------------------------------------------------------- | ----------------------- |
| ![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge\&logo=terraform\&logoColor=white)    | Infrastructure as Code  |
| ![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge\&logo=amazonaws\&logoColor=white)                | Cloud Hosting           |
| ![Jenkins](https://img.shields.io/badge/Jenkins-%23D24939.svg?style=for-the-badge\&logo=jenkins\&logoColor=white)          | CI/CD Pipeline          |
| ![SonarQube](https://img.shields.io/badge/SonarQube-%234E9BCD.svg?style=for-the-badge\&logo=sonarqube\&logoColor=white)    | Code Quality            |
| ![Docker](https://img.shields.io/badge/Docker-%230db7ed.svg?style=for-the-badge\&logo=docker\&logoColor=white)             | Containerization        |
| ![Kubernetes](https://img.shields.io/badge/Kubernetes-%23326ce5.svg?style=for-the-badge\&logo=kubernetes\&logoColor=white) | Container Orchestration |
| ![ArgoCD](https://img.shields.io/badge/ArgoCD-%23EF7B4D.svg?style=for-the-badge\&logo=argo\&logoColor=white)               | GitOps CD               |
| ![Prometheus](https://img.shields.io/badge/Prometheus-%23E6522C.svg?style=for-the-badge\&logo=prometheus\&logoColor=white) | Monitoring              |
| ![Grafana](https://img.shields.io/badge/Grafana-%23F46800.svg?style=for-the-badge\&logo=grafana\&logoColor=white)          | Dashboard Visualization |

---

## ⚙️ Infrastructure Setup

### 1️⃣ Provision EC2 Host via Terraform

```bash
cd terraform
terraform init
terraform plan
terraform apply -auto-approve
```

🖼️ *EC2 Instance Created:*
![EC2 Instance](ec2.png)

---

### 2️⃣ Install Required Tools on EC2

```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install docker.io docker-compose-v2 -y
sudo usermod -aG docker $USER && newgrp docker
sudo systemctl enable docker && sudo systemctl start docker

# Java & Jenkins
sudo apt install fontconfig openjdk-21-jre -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update && sudo apt-get install jenkins -y

# SonarQube, Trivy, AWS CLI, eksctl, kubectl
```

---

### 3️⃣ Configure AWS & EKS

```bash
aws configure
eksctl create cluster \
  --name my-cluster \
  --version 1.28 \
  --region us-east-1 \
  --nodegroup-name linux-nodes \
  --node-type t2.large \
  --nodes 2
```

---

## 🚀 CI/CD Pipeline

### Jenkins CI Pipeline (Build, Scan, Push)

🖼️ *CI Pipeline Screenshot:*
![CI](CI.png)

---

### Jenkins CD Pipeline (Deploy to EKS)

🖼️ *CD Pipeline Screenshot:*
![CD](CD.png)

---

### Email Notification after Pipeline Success

🖼️ *Email Screenshot:*
![Email](email.png)

---

## 📦 Kubernetes & ArgoCD Setup

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
kubectl get svc -n argocd
```

🖼️ *ArgoCD UI:*
![ArgoCD1](argocd1.png)
![ArgoCD2](argocd2.png)

---

## 📊 Monitoring — Prometheus & Grafana

### Install via Helm

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Prometheus
helm install prometheus prometheus-community/prometheus --namespace monitoring --create-namespace
kubectl patch svc prometheus-server -n monitoring -p '{"spec": {"type": "NodePort"}}'

# Grafana
helm install grafana grafana/grafana --namespace monitoring
kubectl patch svc grafana -n monitoring -p '{"spec": {"type": "NodePort"}}'
```

🖼️ *Prometheus & Grafana UI:*
![Grafana](grafana.png)

---

## 🖼️ Output Screenshots

| Description                  | Image                       |
| ---------------------------- | --------------------------- |
| Pipeline Success Output      | ![Output1](output.png)      |
| Pipeline Output (Stage View) | ![Output2](output2.png)     |
| SonarQube Analysis           | ![SonarQube](sonarqube.png) |

---

## 📌 Commands Reference

```bash
# Terraform
terraform init
terraform plan
terraform apply -auto-approve

# AWS CLI
aws configure

# EKS Cluster
eksctl create cluster ...

# ArgoCD NodePort Access
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'

# Prometheus NodePort Access
kubectl patch svc prometheus-server -n monitoring -p '{"spec": {"type": "NodePort"}}'

# Grafana NodePort Access
kubectl patch svc grafana -n monitoring -p '{"spec": {"type": "NodePort"}}'
```

---



---

If you want, I can now give you a **separate `.md` file** with this exact README so you can directly push to GitHub without formatting issues.
Do you want me to prepare that file?
