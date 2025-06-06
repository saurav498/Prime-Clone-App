# 📽️ Amazon Prime Video Clone – CI/CD Pipeline

## 🚀 Overview

This project demonstrates a robust **CI/CD pipeline implementation** using Jenkins to deploy a clone of the Amazon Prime Video application. The pipeline performs:

- Code checkout
- Static code analysis with **SonarQube**
- Security scanning with **Trivy**
- Docker image build and push to **AWS ECR**
- Continuous deployment using **ArgoCD**
- Monitoring with **Prometheus & Grafana**

This end-to-end automation workflow ensures high-quality, secure, and observable deployments.

---

## 🛠️ Tools & Technologies Used

| Tool                | Purpose                                                                 |
|---------------------|-------------------------------------------------------------------------|
| **Jenkins**         | Orchestrates the CI/CD pipeline                                         |
| **SonarQube**       | Performs static code analysis & enforces quality gates                 |
| **Trivy**           | Scans the application for security vulnerabilities                     |
| **Docker**          | Containerizes the application                                           |
| **AWS ECR**         | Hosts container images for deployment                                  |
| **AWS CLI**         | Interacts with AWS services programmatically                           |
| **ArgoCD**          | Automates deployment from ECR to Kubernetes                            |
| **Prometheus**      | Gathers performance metrics for monitoring                             |
| **Grafana**         | Visualizes metrics collected by Prometheus                             |

---

## 🧱 Pipeline Stages

1. **🔁 Git Checkout**  
   Pulls source code from [GitHub](https://github.com/saurav498/Prime-Clone-Project.git).

2. **🔍 SonarQube Analysis**  
   Performs static analysis for bugs, code smells, and vulnerabilities.

3. **✅ Quality Gate**  
   Halts the pipeline if SonarQube’s quality gate fails.

4. **📦 npm Install**  
   Installs project dependencies using `npm install`.

5. **🔐 Trivy Security Scan**  
   Scans source code and dependencies for known vulnerabilities. Results are saved to `trivy.txt`.

6. **🐳 Docker Build**  
   Builds the Docker image using the provided Dockerfile.

7. **📤 Create ECR Repository (If Not Exists)**  
   Checks if the ECR repo exists, and creates it if missing.

8. **🏷️ Tag & Push Docker Image**  
   Tags the image with `latest` and the Jenkins `BUILD_NUMBER`, then pushes to ECR.

9. **🧹 Cleanup Docker Images**  
   Deletes local Docker images to conserve disk space on the Jenkins host.

10. **🚀 ArgoCD, Prometheus & Grafana Setup**  
   - **ArgoCD** auto-deploys the pushed Docker image to Kubernetes  
   - **Prometheus & Grafana** monitor the health and performance of the deployed application

---

## ☁️ Infrastructure Configuration

### EC2 Instance

- OS: Ubuntu 24.04  
- Instance Type: `t3.medium`  
- Disk: 30 GiB

### Security Group Rules

| Port | Purpose      |
|------|--------------|
| 22   | SSH          |
| 80   | HTTP         |
| 443  | HTTPS        |
| 3000 | NodeJS App   |
| 8080 | Jenkins      |
| 9000 | SonarQube    |

---

## 🔌 Jenkins Configuration

### Plugins Used

- SonarQube Scanner
- NodeJS Plugin
- Docker Pipeline
- Docker Commons
- Docker API
- SSH Agent
- Eclipse Temurin Installer (OpenJDK)
- Prometheus Metrics
- Pipeline: Stage View

### Global Tool Configuration

| Tool              | Version/Source                          |
|-------------------|-----------------------------------------|
| **JDK**           | jdk17 from adoptium.net                 |
| **Sonar Scanner** | 6.2.0.4584 from Maven Central           |
| **Node.js**       | 16.20.0 from nodejs.org                 |
| **Docker**        | Latest version from docker.com          |

---

## 🧠 SonarQube Configuration

### Webhook

- **Name**: `sonarqube-webhook`  
- **URL**: `http://<jenkins-server>:8080/sonarqube-webhook/`  
- **Secret**: None  

### SonarQube Token

- Used for secure communication between Jenkins and SonarQube

---

## 🔐 Credentials Used

- **AWS Access Key / Secret Key**  
  For authenticating and pushing Docker images to AWS ECR  
- **SonarQube Token**  
  For Jenkins-to-SonarQube integration

---

## 🔄 Flow of Execution

1. **Source Checkout** – Jenkins pulls the code from GitHub  
2. **Static Analysis** – SonarQube checks the codebase for quality issues  
3. **Dependency Installation** – Installs required `npm` packages  
4. **Security Scan** – Trivy scans for CVEs in source and dependencies  
5. **Docker Build** – The app is containerized  
6. **ECR Push** – Docker image is pushed to ECR  
7. **ArgoCD Deployment** – Deployed to Kubernetes cluster  
8. **Monitoring** – Metrics collected by Prometheus and visualized in Grafana

---

## 📌 Conclusion

This project showcases a **production-grade CI/CD pipeline**:

- ✅ Code Quality Assurance with SonarQube  
- ✅ Security Scanning with Trivy  
- ✅ Automated Docker Builds  
- ✅ AWS ECR Integration  
- ✅ GitOps Deployment with ArgoCD  
- ✅ Real-time Monitoring with Prometheus and Grafana

> 🔧 A great demonstration of modern DevOps practices with full CI/CD automation and infrastructure observability.

---

