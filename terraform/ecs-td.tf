##########################################################
# ECS Task Definition for Strapi + RDS (no EFS)
##########################################################

resource "aws_ecs_task_definition" "TD" {
  family                   = "strapi-postgres"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = data.aws_iam_role.ecs_task_exec_role.arn
  network_mode             = "awsvpc"
  cpu                      = 2048
  memory                   = 4096

  container_definitions = jsonencode([
    # ==================== POSTGRES CONTAINER ====================
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

      # Health Check for Postgres
      healthCheck = {
        command     = ["CMD-SHELL", "pg_isready -U strapi"]
        interval    = 30
        timeout     = 5
        retries     = 5
        startPeriod = 10
      }

      # Logging
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/postgres"
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "postgres"
        }
      }
    },

    # ==================== STRAPI CONTAINER ====================
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
        { name = "DATABASE_CLIENT", value = "postgres" },
        { name = "DATABASE_HOST", value = "localhost" },
        { name = "DATABASE_PORT", value = "5432" },
        { name = "DATABASE_NAME", value = "strapidb" },
        { name = "DATABASE_USERNAME", value = "strapi" },
        { name = "DATABASE_PASSWORD", value = var.db_password },
        { name = "NODE_ENV", value = "production" },
        { name = "JWT_SECRET", value = "jwtsecret" },
        { name = "ADMIN_JWT_SECRET", value = "adminsecret" },
        { name = "API_TOKEN_SALT", value = "randomsalt" },
        { name = "APP_KEYS", value = "key1,key2,key3" }
      ]

      dependsOn = [
        {
          containerName = "postgres-container"
          condition     = "HEALTHY"
        }
      ]

      # Logging
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/strapi"
          "awslogs-region"        = "ap-south-1"
          "awslogs-stream-prefix" = "strapi"
        }
      }
    }
  ])
}

##########################################################
# CloudWatch Log Groups
##########################################################
resource "aws_cloudwatch_log_group" "strapi_log_group" {
  name              = "/ecs/strapi"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "postgres_log_group" {
  name              = "/ecs/postgres"
  retention_in_days = 7
}
