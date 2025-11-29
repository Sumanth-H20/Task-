EKS Cluster + ArgoCD + NGINX Deployment (Terraform + GitOps)
Overview

This project provisions an Amazon EKS Kubernetes cluster using Terraform, deploys ArgoCD for GitOps-based application delivery, and exposes a sample NGINX application via Kubernetes Service.


Prerequisites

Before starting, ensure you have the following installed on your Terraform machine:
Terraform ≥ 1.0
AWS CLI
kubectl
Helm ≥ v3
AWS IAM credentials configured
aws configure

Provisioning EKS Cluster Using Terraform

Initialize Terraform
terraform init

Review the plan
terraform plan

Apply the changes
terraform apply

this will create:
VPC
Subnets
EKS Cluster
EKS Node Group
IAM Roles
Required networking resources

configure kubectl to Access the EKS Cluster
aws eks --region ap-south-1 update-kubeconfig --name nginx-eks-cluster

Verify cluster connectivity:
kubectl get nodes   -- ready state

Install ArgoCD

Create ArgoCD Namespace
kubectl create namespace argocd

Install argocd
kubectl apply -n argocd \
  -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Port-forward the ArgoCD API Server
kubectl port-forward svc/argocd-server -n argocd 8080:443


Check ArgoCD Podskubectl get pods -n argocd  -- running state

Access ArgoCD Web UI

Open ArgoCD UI - Open in browser
https://65.2.79.114:8080

Get Initial Admin Password
kubectl get secret argocd-initial-admin-secret -n argocd \
 -o jsonpath="{.data.password}" | base64 -d
 
 Username: admin
 password you will get from above command

 login to argo-cd

 
Create argocd/application.yaml

Apply ArgoCD Application

kubectl apply -f argocd/application.yaml


Access NGINX Application

kubectl port-forward svc/nginx-service 8081:80

http://65.2.79.114:8081
