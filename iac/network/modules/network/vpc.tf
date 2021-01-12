resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
