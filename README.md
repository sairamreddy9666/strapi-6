# Task definition log file

{
  "compatibilities": [
    "EC2",
    "FARGATE"
  ],
  "containerDefinitions": [
    {
      "cpu": 0,
      "environment": [
        {
          "name": "POSTGRES_USER",
          "value": "strapi"
        },
        {
          "name": "POSTGRES_PASSWORD",
          "value": "strapi"
        },
        {
          "name": "POSTGRES_DB",
          "value": "strapidb"
        }
      ],
      "essential": true,
      "image": "145065858967.dkr.ecr.ap-south-1.amazonaws.com/sairam/strapi/task-5:latest",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/sairam-ecs-td",
          "awslogs-region": "ap-south-1",
          "awslogs-stream-prefix": "postgres"
        },
        "secretOptions": []
      },
      "mountPoints": [],
      "name": "postgres-container",
      "portMappings": [
        {
          "containerPort": 5432,
          "hostPort": 5432,
          "name": "postgres-container-5432-tcp",
          "protocol": "tcp"
        }
      ],
      "systemControls": [],
      "volumesFrom": []
    },
    {
      "cpu": 0,
      "environment": [
        {
          "name": "API_TOKEN_SALT",
          "value": "randomsalt"
        },
        {
          "name": "APP_KEYS",
          "value": "key1,key2,key3"
        },
        {
          "name": "DATABASE_NAME",
          "value": "strapidb"
        },
        {
          "name": "JWT_SECRET",
          "value": "jwtsecret"
        },
        {
          "name": "DATABASE_HOST",
          "value": "localhost"
        },
        {
          "name": "ADMIN_JWT_SECRET",
          "value": "adminsecret"
        },
        {
          "name": "DATABASE_PORT",
          "value": "5432"
        },
        {
          "name": "DATABASE_USERNAME",
          "value": "strapi"
        },
        {
          "name": "DATABASE_CLIENT",
          "value": "postgres"
        },
        {
          "name": "DATABASE_PASSWORD",
          "value": "strapi"
        }
      ],
      "essential": true,
      "image": "145065858967.dkr.ecr.ap-south-1.amazonaws.com/sairam/strapi/task-5@sha256:d0b279e474c1edf9e957d89c3451dadb5593c6f9540e832ddf7ae7b25f8fe0a5",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/sairam-ecs-td",
          "awslogs-region": "ap-south-1",
          "awslogs-stream-prefix": "strapi"
        },
        "secretOptions": []
      },
      "mountPoints": [],
      "name": "strapi-container",
      "portMappings": [
        {
          "containerPort": 1337,
          "hostPort": 1337,
          "name": "strapi-container-1337-tcp",
          "protocol": "tcp"
        }
      ],
      "systemControls": [],
      "volumesFrom": []
    }
  ],
  "cpu": "1024",
  "executionRoleArn": "arn:aws:iam::145065858967:role/ecsTaskExecutionRole",
  "family": "sairam-ecs-td",
  "memory": "2048",
  "networkMode": "awsvpc",
  "placementConstraints": [],
  "registeredAt": "2025-09-25T09:18:06.274Z",
  "registeredBy": "arn:aws:iam::145065858967:user/sairambadari038@gmail.com",
  "requiresAttributes": [
    {
      "name": "com.amazonaws.ecs.capability.logging-driver.awslogs"
    },
    {
      "name": "ecs.capability.execution-role-awslogs"
    },
    {
      "name": "com.amazonaws.ecs.capability.ecr-auth"
    },
    {
      "name": "com.amazonaws.ecs.capability.docker-remote-api.1.19"
    },
    {
      "name": "com.amazonaws.ecs.capability.docker-remote-api.1.21"
    },
    {
      "name": "com.amazonaws.ecs.capability.task-iam-role"
    },
    {
      "name": "ecs.capability.execution-role-ecr-pull"
    },
    {
      "name": "com.amazonaws.ecs.capability.docker-remote-api.1.18"
    },
    {
      "name": "ecs.capability.task-eni"
    }
  ],
  "requiresCompatibilities": [
    "FARGATE"
  ],
  "revision": 10,
  "status": "ACTIVE",
  "taskDefinitionArn": "arn:aws:ecs:ap-south-1:145065858967:task-definition/sairam-ecs-td:10",
  "taskRoleArn": "arn:aws:iam::145065858967:role/sairam-ecs-s3fullaccess",
  "volumes": [],
  "tags": []
}
