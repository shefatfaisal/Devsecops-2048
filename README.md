# 🎮 DevSecOps 2048 — CI/CD on AWS EKS

> A 2048 game shipped through a full DevSecOps pipeline: Jenkins builds it, SonarQube and Trivy scan it, Docker packages it, Terraform-provisioned EKS runs it, and Prometheus/Grafana watch it.

[![Made with React](https://img.shields.io/badge/React-17-61DAFB?logo=react&logoColor=white)](https://reactjs.org/) [![TypeScript](https://img.shields.io/badge/TypeScript-4.x-3178C6?logo=typescript&logoColor=white)](https://www.typescriptlang.org/) [![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?logo=docker&logoColor=white)](https://www.docker.com/) [![Kubernetes](https://img.shields.io/badge/Kubernetes-EKS-326CE5?logo=kubernetes&logoColor=white)](https://aws.amazon.com/eks/) [![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform&logoColor=white)](https://www.terraform.io/) [![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?logo=jenkins&logoColor=white)](https://www.jenkins.io/) [![SonarQube](https://img.shields.io/badge/SonarQube-Code%20Quality-4E9BCD?logo=sonarqube&logoColor=white)](https://www.sonarsource.com/) [![Trivy](https://img.shields.io/badge/Trivy-Security%20Scan-1904DA)](https://aquasecurity.github.io/trivy/) [![Prometheus](https://img.shields.io/badge/Prometheus-Monitoring-E6522C?logo=prometheus&logoColor=white)](https://prometheus.io/) [![Grafana](https://img.shields.io/badge/Grafana-Dashboards-F46800?logo=grafana&logoColor=white)](https://grafana.com/) ![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

This repo documents a DevOps/Cloud internship project: taking a simple React + TypeScript 2048 game and wrapping it in a production-style DevSecOps pipeline — infrastructure as code, automated security and quality gates, a Kubernetes deployment on AWS, and full observability.

---

## 🧰 Tech Stack

|Layer|Tools|
|---|---|
|**Application**|React 17, TypeScript, CRACO|
|**Containerization**|Docker, Docker Hub|
|**CI/CD**|Jenkins (declarative pipelines)|
|**Infrastructure as Code**|Terraform (S3 remote state backend)|
|**Orchestration**|Kubernetes (AWS EKS), `kubectl`, `eksctl`|
|**Code Quality**|SonarQube (SAST + Quality Gate)|
|**Security Scanning**|Trivy (filesystem & container image scans)|
|**Observability**|Prometheus, Node Exporter, Grafana|
|**Cloud**|AWS (EC2, EKS, IAM, S3)|

---

## 📁 Project Structure

```
Devsecops-2048/
├── Dockerfile                       # Multi-stage build for the React app
├── deployment.yaml                  # Kubernetes Deployment + LoadBalancer Service
├── package.json
├── craco.config.js
├── docs/
│   └── SETUP_GUIDE.md               # Full step-by-step setup walkthrough
├── scripts/
│   ├── script1.sh                   # Jenkins + Docker bootstrap
│   ├── script2.sh                   # Terraform, kubectl & AWS CLI
│   ├── trivy.sh                     # Trivy install
│   ├── promo.sh                     # Prometheus install + systemd service
│   ├── nodeexp.sh                   # Node Exporter install + systemd service
│   ├── grafana.sh                   # Grafana install
│   └── configure-jenkins-target.sh  # Registers Jenkins as a Prometheus target
├── EKS_TERRAFORM/
│   ├── provider.tf                  # AWS provider config
│   ├── backend.tf                   # S3 remote state backend
│   └── main.tf                      # EKS cluster, node group & IAM roles
├── public/
└── src/
    ├── App.tsx
    ├── components/
    ├── hooks/
    └── styles/
```

---

## 📚 What I Learned

- Provisioning cloud infrastructure (EKS, IAM roles, networking) as code with Terraform and a remote S3 backend
- Designing parameterized, multi-stage Jenkins pipelines for two distinct workflows (infra vs. app)
- Wiring static analysis and a Quality Gate into CI so bad code fails the build, not production
- Using Trivy to scan both source dependencies and the final container image
- Containerizing a React/TypeScript app and publishing it through Docker Hub
- Deploying and exposing a containerized app on Kubernetes via a Deployment + LoadBalancer Service
- Standing up an observability stack (Prometheus, Node Exporter, Grafana) and scraping Jenkins build metrics into it
- Managing secrets through Jenkins' Credentials Store instead of hardcoding them
- Debugging real infrastructure issues: Docker API mismatches, IAM role conflicts, security-group-blocked LoadBalancers, and non-idempotent setup scripts

---

## 👤 Author

**Shefat Faisal** GitHub: [@shefatfaisal](https://github.com/shefatfaisal)

Built as part of a DevOps/Cloud internship project — deploying a game end-to-end through a real DevSecOps pipeline, with full observability.

Game UI originally based on [Mateusz Sokola's 2048-in-react](https://github.com/mateuszsokola/2048-in-react).

---

## 📄 License

Licensed under the MIT License.