# -----------------------------------------------------------------------------
# IAM - EKS Nodes Instance Profile
# -----------------------------------------------------------------------------

resource "aws_iam_instance_profile" "eks_nodes" {
  name = format("ip-eks-nodes-%s", var.cluster_name)
  role = aws_iam_role.eks_nodes.name
}

# -----------------------------------------------------------------------------
# IAM - EKS Nodes Role
# -----------------------------------------------------------------------------

data "aws_iam_policy_document" "assume_service_role_eks_nodes" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_nodes" {
  name = format("eks-nodes-%s", var.cluster_name)

  assume_role_policy = data.aws_iam_policy_document.assume_service_role_eks_nodes.json
}

# -----------------------------------------------------------------------------
# IAM - EKS Nodes Policies
# -----------------------------------------------------------------------------


resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2RoleforSSM" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}
