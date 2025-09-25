resource "aws_ecs_task_definition" "TD" {
  family                   = "strapi-postgres"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = "arn:aws:iam::145065858967:role/sairam-ecs-task-execution-role"
  task_role_arn            = "arn:aws:iam::145065858967:role/sairam-ecs-task-role"
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  container_definitions = jsonencode([
    {
      name      = "strapi-container"
      image     = "sairambadari/strapi:latest"
      cpu       = 1024
      memory    = 2048
      essential = true
      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "DATABASE_HOST", value = "postgres-container" },
        { name = "DATABASE_PORT", value = "5432" },
        { name = "DATABASE_NAME", value = "strapidb" },
        { name = "DATABASE_USERNAME", value = "strapi" },
        { name = "DATABASE_PASSWORD", value = var.db_password }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/strapi"
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "strapi"
        }
      }
    },
    {
      name      = "postgres-container"
      image     = "sairambadari/postgres:15-alpine"
      cpu       = 512
      memory    = 1024
      essential = true
      portMappings = [
        {
          containerPort = 5432
          hostPort      = 5432
          protocol      = "tcp"
        }
      ]
      environment = [
        { name = "POSTGRES_USER", value = "strapi" },
        { name = "POSTGRES_PASSWORD", value = var.db_password },
        { name = "POSTGRES_DB", value = "strapidb" }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/postgres"
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "postgres"
        }
      }
    }
  ])
}
