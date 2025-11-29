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
onfigure kubectl to Access the EKS Cluster
aws eks --region ap-south-1 update-kubeconfig --name nginx-eks-cluster
Verify cluster connectivity:
kubectl get nodes   -- ready state
Install ArgoCD
Create ArgoCD Namespace
kubectl create namespace argocd
Install ArgoCD using Helm
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm install argocd argo/argo-cd -n argocd
Check ArgoCD Podskubectl get pods -n argocd  -- running state

Access ArgoCD Web UI
Port-forward the ArgoCD API Server
kubectl port-forward svc/argocd-server -n argocd 8080:443

Open ArgoCD UI
Open in browser
https://65.2.79.114:8080

Get Initial Admin Password
kubectl get secret argocd-initial-admin-secret -n argocd \
 -o jsonpath="{.data.password}" | base64 -d
 Username: admin
 password you will get from above command

 login to argo-cd

 now Deploy NGINX using ArgoCD or kubectl
 kubectl create deployment nginx --image=nginx -n default
 kubectl port-forward deployment/nginx 8081:80 -n default
 Check the service
 kubectl get svc nginx -n default

http://65.2.79.114:8081
