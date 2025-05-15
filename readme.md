# Inception-of-Things (IoT)

## Overview

_Inception-of-Things_ is a system administration project designed to introduce students to Kubernetes through practical experience with **K3s**, **K3d**, **Vagrant**, and **ArgoCD**. This project simulates realistic deployment environments to build foundational knowledge of container orchestration, infrastructure automation, and continuous delivery workflows.

## Project Goals

The primary objective of this project is to help students:
- Understand the architecture and basics of **Kubernetes** through **K3s** (a lightweight Kubernetes distribution).
- Learn how to manage **multi-node clusters** using **Vagrant** and **VirtualBox** to simulate real infrastructure.
- Deploy and expose **web applications** using Kubernetes **Ingress**.
- Work with **K3d**, a container-based solution to run Kubernetes clusters locally with Docker.
- Set up and manage **ArgoCD**, a GitOps continuous delivery tool that automates deployments from a **GitHub** repository.
- Manage application versions through **Git-based pipelines**.
- Optionally, extend the project by integrating a local **GitLab** instance for full internal DevOps management.

## Key Technologies

- **Vagrant**: Infrastructure provisioning tool to define and manage virtual machines.
- **VirtualBox**: Virtualization platform to run Linux-based virtual machines on macOS or Linux.
- **K3s**: Lightweight Kubernetes distribution optimized for resource-constrained environments.
- **K3d**: Runs K3s clusters in Docker containers for faster local development.
- **Kubectl**: Command-line tool to interact with Kubernetes clusters.
- **Ingress**: Kubernetes resource to manage external access to services based on hostnames.
- **ArgoCD**: GitOps continuous delivery controller for Kubernetes.
- **Docker & DockerHub**: Container technology and public image registry.
- **GitHub**: Version control and source of truth for application deployments.
- **GitLab (Bonus)**: Self-hosted Git platform to manage code and automate CI/CD pipelines.

## Learning Outcomes

By completing this project, students will gain:
- Practical experience with container orchestration using Kubernetes.
- Skills to provision and manage virtualized infrastructure with Vagrant and VirtualBox.
- Knowledge of deploying and exposing applications in Kubernetes using Ingress.
- Hands-on experience with GitOps practices using ArgoCD and GitHub.
- Insights into continuous deployment and version management of applications.
- Optional experience in setting up a local GitLab instance to manage internal DevOps workflows.

---

> **Note**: This project is fully evaluated in a controlled Linux environment and must comply with strict evaluation guidelines. All deliverables must be provided in the correct repository structure as specified in the project subject.

