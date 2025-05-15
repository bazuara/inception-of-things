# Inception-of-Things (IoT)

<p align="center">
  <img src="./images/iot_logo.png" alt="Inception-of-Things Project Banner" />
</p>

## Overview

Welcome to **Inception-of-Things**, a hands-on system administration project where we explored the world of **Kubernetes**, **DevOps**, and **infrastructure automation**.  
Through this project, we went from spinning up virtual machines to deploying real applications with continuous delivery pipelines, all powered by industry-standard tools.

## What This Project Covers

Throughout this project, we:
- Built and managed lightweight Kubernetes clusters with **K3s**.
- Simulated real infrastructure using **Vagrant** and **VirtualBox**.
- Deployed multiple **web applications** using Kubernetes **Ingress** to manage traffic based on hostnames.
- Ran Kubernetes locally with **K3d** for faster iteration and testing.
- Automated deployments using **ArgoCD** and **GitHub** with a GitOps workflow.
- Managed application versions and rolled out updates directly from Git repositories.
- (Optionally) Integrated a local **GitLab** instance to simulate a fully self-hosted DevOps platform.

## 🛠️ Technologies Used

[![Vagrant](https://img.shields.io/badge/Vagrant-1868F2?style=flat-square&logo=vagrant&logoColor=white&labelColor=1868F2)](https://www.vagrantup.com/)  
Tool for automating the creation and provisioning of virtual machines. Used here to define reproducible development environments for Kubernetes clusters.

[![VirtualBox](https://img.shields.io/badge/VirtualBox-183A61?style=flat-square&logo=virtualbox&logoColor=white&labelColor=183A61)](https://www.virtualbox.org/)  
Open-source virtualization platform. Provided the virtual infrastructure for running isolated Linux machines needed for K3s.

[![K3s](https://img.shields.io/badge/K3s-FF9900?style=flat-square&logo=kubernetes&logoColor=white&labelColor=FF9900)](https://k3s.io/)  
Lightweight Kubernetes distribution. Used to deploy, manage, and expose containerized applications on virtual machines with minimal resource usage.

[![K3d](https://img.shields.io/badge/K3d-FF9900?style=flat-square&logo=docker&logoColor=white&labelColor=FF9900)](https://k3d.io/)  
Tool for running K3s clusters inside Docker containers. Provided a fast and lightweight alternative to full VM-based clusters for testing GitOps workflows.

[![Kubectl](https://img.shields.io/badge/Kubectl-326CE5?style=flat-square&logo=kubernetes&logoColor=white&labelColor=326CE5)](https://kubernetes.io/docs/tasks/tools/)  
Kubernetes CLI. Essential for interacting with the Kubernetes API, managing resources, and verifying deployments.

[![ArgoCD](https://img.shields.io/badge/ArgoCD-FE4C61?style=flat-square&logo=argo&logoColor=white&labelColor=FE4C61)](https://argo-cd.readthedocs.io/)  
GitOps continuous delivery controller. Automated the deployment of applications from Git repositories into Kubernetes clusters.

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white&labelColor=2496ED)](https://www.docker.com/)  
Containerization platform. Used to build, run, and manage container images, including those deployed in K3s and K3d clusters.

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white&labelColor=181717)](https://github.com/)  
Source code management and hosting platform. Served as the source of truth for deployment manifests used by ArgoCD.

[![GitLab](https://img.shields.io/badge/GitLab-FC6D26?style=flat-square&logo=gitlab&logoColor=white&labelColor=FC6D26)](https://about.gitlab.com/)  
Self-hosted Git platform (Bonus). Provided internal repository management and CI/CD capabilities for fully local DevOps workflows.

## What We Learned

By completing this project, we gained hands-on experience in:
- Kubernetes cluster management and application deployment.
- Infrastructure automation with Vagrant and VirtualBox.
- GitOps practices using ArgoCD and GitHub.
- Continuous delivery and version management of containerized applications.
- End-to-end DevOps workflows, including optional GitLab integration for fully self-hosted environments.

---

If you're curious about Kubernetes, DevOps, or how modern infrastructure works behind the scenes, feel free to explore the repository or reach out to discuss it further!