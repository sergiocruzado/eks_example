# -----------------------------------------------------------------------------
# EKS
# -----------------------------------------------------------------------------

output "cluster_name" {
  value = module.eks_cluster.cluster_name
}

output "cluster_id" {
  value = module.eks_cluster.cluster_id
}

output "cluster_version" {
  value = var.cluster_version
}

output "nodes_iam_role_arn" {
  value = module.eks_cluster.nodes_iam_role_arn
}

# -----------------------------------------------------------------------------
# ECR
# -----------------------------------------------------------------------------

output "ecr_name" {
  value = aws_ecr_repository.traefik2.repository_url
}