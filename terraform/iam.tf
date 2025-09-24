# Task execution role (allows pulling from ECR and writing logs)
resource "aws_iam_role" "ecs_task_execution_role" {
name = "ecsTaskExecutionRole-${var.env}"
assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}


data "aws_iam_policy_document" "ecs_task_assume_role" {
statement {
actions = ["sts:AssumeRole"]
principals {
type = "Service"
identifiers = ["ecs-tasks.amazonaws.com"]
}
}
}


resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
role = aws_iam_role.ecs_task_execution_role.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# Task role (for application permissions if needed)
resource "aws_iam_role" "ecs_task_role" {
name = "ecsTaskRole-${var.env}"
assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}
