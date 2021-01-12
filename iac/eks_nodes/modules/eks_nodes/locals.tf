locals {
  module_tags = {
    module         = "eks_nodes"
    module_version = "1.0.0"
  }

  tags = merge(local.module_tags, var.tags)

  module_tags_list = [
    {
      key                 = "module"
      value               = "eks_nodes"
      propagate_at_launch = true
    },
    {
      key                 = "module_version"
      value               = "1.0.0"
      propagate_at_launch = true
    },
    {
      key                 = "Name"
      value               = format("eks-nodes-%s",var.cluster_name)
      propagate_at_launch = true
    },
    {
      key                 = format("kubernetes.io/cluster/%s", var.cluster_name)
      value               = "owned"
      propagate_at_launch = true
    },
  ]

  tags_list = concat(local.module_tags_list, var.tags_list)

  image_id = coalesce(var.image_id, join("", data.aws_ami.eks_nodes.*.id))

}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
