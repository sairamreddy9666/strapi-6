resource "aws_ecs_cluster" "strapi_cluster" {
awslogs-region = var.aws_region
awslogs-stream-prefix = "strapi"
}
}
environment = [
{ name = "NODE_ENV", value = "production" }
]
}
])
}


resource "aws_ecs_service" "strapi_service" {
name = "strapi-service-${var.env}"
cluster = aws_ecs_cluster.strapi_cluster.id
task_definition = aws_ecs_task_definition.strapi_task.arn
desired_count = var.desired_count
launch_type = "FARGATE"


network_configuration {
subnets = local.public_subnet_ids
security_groups = [aws_security_group.task_sg.id]
assign_public_ip = true
}


load_balancer {
target_group_arn = aws_lb_target_group.tg.arn
container_name = "strapi"
container_port = var.container_port
}


depends_on = [aws_lb_listener.http_listener]
}


# Security group for Fargate tasks: allow inbound from ALB on container port
resource "aws_security_group" "task_sg" {
name = "fargate-task-sg-${var.env}"
description = "Allow traffic from ALB to tasks"
vpc_id = data.aws_vpc.default.id


ingress {
from_port = var.container_port
to_port = var.container_port
protocol = "tcp"
security_groups = [aws_security_group.alb_sg.id]
description = "Allow ALB"
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
