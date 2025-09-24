# default VPC & its subnet ids (public subnets used for ALB & Fargate tasks with public IP)
data "aws_vpc" "default" {
default = true
}


data "aws_subnet_ids" "default" {
vpc_id = data.aws_vpc.default.id
}


# pick the first two subnets (if available) for ALB and tasks
locals {
subnet_ids = data.aws_subnet_ids.default.ids
public_subnet_ids = length(local.subnet_ids) >= 2 ? slice(local.subnet_ids, 0, 2) : local.subnet_ids
}
