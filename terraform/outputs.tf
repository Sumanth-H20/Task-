output "kubeconfig" {
  description = "Kubeconfig content for the EKS cluster (sensitive)"
  value       = module.eks.kubeconfig
  sensitive   = true
}
